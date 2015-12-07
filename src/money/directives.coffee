'use strict'

angular.module 'touk.money.directives', [
	'touk.money.filters'
	'drahak.hotkeys'
]

.directive 'unitFloat', ->
	restrict: 'A'
	require: ['unitFloat','ngModel']
	bindToController:
		value: '=ngModel'
		step: '=?'
		allowNegative: '=?'
		precision: '=?'
		translateFn: '&?'
		filter: '@?'
		prefix: '@?'
		suffix: '@?'

	controller: [
		'HotKeysElement', '$element', '$parse'
		class UnitFloat
			step: 1
			allowNegative: yes

			keyUp: 'up'
			keyUpFast: 'up+shift'
			keyDown: 'down'
			keyDownFast: 'down+shift'

			constructor: (HotKeysElement, element, @$parse) ->
				@$hotkeys = HotKeysElement element

				@bindKeys()

			bindKeys: =>
				@$hotkeys
				.bind @keyUp, => @change +1
				.bind @keyUpFast, => @change +10
				.bind @keyDown, => @change -1
				.bind @keyDownFast, => @change -10

			unbindKeys: =>
				@$hotkeys
				.unbind @keyUp
				.unbind @keyUpFast
				.unbind @keyDown
				.unbind @keyDownFast

			destructor: =>
				@unbindKeys()

			change: (amount) =>
				value = @model.$modelValue or 0
				value = value + amount * @step
				value = @getPositive(value) unless @allowNegative
				@value = value
				@model.$setDirty()

			parser: (value) =>
				return null unless value

				quantity = value.toString()
				.replace /\./g, ','
				.replace /[^-\d,]/g, ''
				.replace /[,](\d*)$/g, '.$10'

				quantity = parseFloat(quantity)
				quantity = @getPositive(quantity) unless @allowNegative

				return null if isNaN quantity
				@round quantity

			formatter: (value) =>
				quantity = parseFloat(value)

				return null if isNaN quantity

				quantity = @round quantity

				if @translateFn? and not @filter
					value = @translateFn value: quantity
				else
					filter = @filter or "unitFloat : #{@getPositive(@precision)}"
					value = @applyFilter quantity, filter

				return "#{@prefix or ''}#{value}#{@suffix or ''}"

			getPositive: (value = 0) -> Math.max value, 0

			round: (value) => @applyFilter value, "decimal : #{@getPositive(@precision)}"

			applyFilter: (quantity, filter) -> do @$parse "#{quantity} | #{filter}"

			render: => do @render = _.debounce =>
				val = @formatter @parser @model.$viewValue
				return if @model.$viewValue is val
				@model.$viewValue = val
				@model.$render()
			, @model.$options?.debounce or 100
	]
	controllerAs: 'UF'

	link: (scope, element, attrs, ctrls) ->
		[UF, UF.model] = ctrls

		UF.model.$parsers.unshift UF.parser
		UF.model.$formatters.unshift UF.formatter

		element.on 'blur paste', UF.render
		scope.$watch 'UF', UF.render, yes

		scope.$on '$destroy', UF.destructor

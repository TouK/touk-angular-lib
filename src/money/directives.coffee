'use strict'

angular.module 'touk.money.directives', [
	'touk.money.filters'
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
		ceiling: '=?max'
		floor: '=?min'
	scope: yes
	controller: class UnitFloat
		step: 1
		allowNegative: yes

		keyUp: 38
		keyDown: 40

		@$inject: ['$element', '$parse']
		constructor: (@$element, @$parse) ->

		bindEvents: =>
			@$element.on 'keydown', (event) =>
				switch event.which
					when @keyUp
						@change if event.shiftKey then +10 else +1
						event.preventDefault()
					when @keyDown
						@change if event.shiftKey then -10 else -1
						event.preventDefault()

			@$element.on 'blur paste keydown', =>
				@render()

		unbindEvents: =>
			@$element.off()

		destructor: =>
			@unbindEvents()

		change: (amount) =>
			value = @model.$modelValue or 0

			step = 1
			step = step/10 for i in [0...@getPositive @precision]
			step = Math.max @step, step

			value += amount * step
			value = @round value
			value = @getPositive(value) unless @allowNegative
			@model.$setDirty()
			@model.$setViewValue @formatter value
			@model.$render()

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

		fix: (value) =>
			floor = Math.min(@floor, @ceiling) or @floor
			ceiling = Math.max(@floor, @ceiling) or @ceiling

			min = Math.min(value, ceiling)
			value = min unless isNaN min

			max = Math.max(value, floor)
			value = max unless isNaN max

			return value

		round: (value) =>
			@applyFilter @fix(value), "decimal : #{@getPositive(@precision)}"

		applyFilter: (quantity, filter) -> do @$parse "#{quantity} | #{filter}"

		render: =>
			@render = _.debounce =>
				val = @formatter @parser @model.$viewValue
				return if @model.$viewValue is val
				@model.$setViewValue val
				@model.$render()
			, (@model?.$options?.debounce or 800)

			do @render


	controllerAs: 'UF'

	link: (scope, element, attrs, ctrls) ->
		[UF, UF.model] = ctrls

		UF.model.$parsers.unshift UF.parser
		UF.model.$formatters.unshift UF.formatter

		UF.bindEvents()

		scope.$watch 'UF', ->
			UF.render()
		, yes

		scope.$on '$destroy', ->
			UF.destructor()

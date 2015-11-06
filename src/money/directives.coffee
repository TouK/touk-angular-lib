'use strict'

angular.module 'touk.money.directives', [
	'touk.money.filters'
	'drahak.hotkeys'
]

.directive 'unitFloat', [
	'$parse', '$filter', 'HotKeysElement'
	($parse, $filter, HotKeys)->
		restrict: 'A'
		require: 'ngModel'
		link: (scope, element, attrs, ctrl) ->
			step = 1
			attrs.$observe 'step', (value) -> step = value if value?

			keyUp = 'up'
			keyUpFast = 'up+shift'
			keyDown = 'down'
			keyDownFast = 'down+shift'

			setter = $parse(attrs.ngModel).assign

			change = (amount) ->
				value = ctrl.$modelValue or 0
				value = value + amount * step
				value = Math.max(value, 0) unless attrs.allowNegative
				setter scope, value
				ctrl.$setDirty()

			hotkeys = HotKeys element
			hotkeys.bind keyUp, -> change +1
			hotkeys.bind keyUpFast, -> change +10
			hotkeys.bind keyDown, -> change -1
			hotkeys.bind keyDownFast, -> change -10

			scope.$on '$destroy', ->
				hotkeys
				.unbind keyUp
				.unbind keyUpFast
				.unbind keyDown
				.unbind keyDownFast

			parser = (value) ->
				return null unless value

				quantity = value.toString()
				.replace /\./g, ','
				.replace /[^-\d,]/g, ''
				.replace /[,](\d*)$/g, '.$10'

				quantity = parseFloat(quantity)
				quantity = Math.max(quantity, 0) unless attrs.allowNegative

				return null if isNaN quantity
				quantity.decimal attrs.precision

			translateFn = $parse(attrs.translateFn) scope
			formatter = (value) ->
				quantity = parseFloat(value)

				return null if isNaN quantity

				quantity = quantity.decimal attrs.precision
				if translateFn and not attrs.filter
					value = translateFn quantity
				else
					if attrs.filter
						filter = ' ' + $filter(attrs.filter) quantity, yes
					value = $filter('unitFloat')(quantity, attrs.precision) + (filter or '')
				return "#{attrs.prefix or ''}#{value}#{attrs.suffix or ''}"


			ctrl.$parsers.unshift parser
			ctrl.$formatters.unshift formatter

			element.on 'blur paste', _.debounce ->
				val = formatter parser ctrl.$viewValue
				return if ctrl.$viewValue is val
				ctrl.$viewValue = val
				ctrl.$render()
			, ctrl.$options?.debounce or 800

]

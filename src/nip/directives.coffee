'use strict'

angular.module 'touk.nip.directives', [
	'touk.nip.filters'
	'touk.nip.validator'
]

.directive 'maskNip', ['$filter', ($filter) ->
	restrict: 'A'
	require: '?ngModel'
	link: (scope, element, attrs, ctrl) ->
		return unless ctrl?

		parser = (value) ->
			value?.replace /[^0-9]/g, ''

		formatter = (value) ->
			$filter('maskNip') value

		ctrl.$parsers.unshift parser
		ctrl.$formatters.push formatter

		element.on 'blur paste', _.debounce ->
			val = formatter parser ctrl.$viewValue
			return if ctrl.$viewValue is val
			ctrl.$viewValue = val
			ctrl.$render()
		, ctrl.$options?.debounce or 800
]

.directive 'validateNip', ['nip', (validator) ->
	restrict: 'A'
	require: '?ngModel'
	link: (scope, element, attrs, ctrl) ->
		return unless ctrl?
		ctrl.$validators.nip = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or validator.validate value

]
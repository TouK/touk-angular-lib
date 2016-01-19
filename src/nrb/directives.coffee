'use strict'

angular.module 'touk.nrb.directives', [
	'touk.nrb.filters'
	'touk.nrb.validators'
]

.directive 'maskNrb', ['$filter', ($filter) ->
	restrict: 'A'
	require: '?ngModel'
	link: (scope, element, attrs, ctrl) ->
		return unless ctrl?

		parser = (value) ->
			value?.replace /[^0-9]/g, ''

		formatter = (value) ->
			$filter('maskNrb') value

		ctrl.$parsers.unshift parser
		ctrl.$formatters.push formatter

		element.on 'blur paste', _.debounce ->
			val = formatter parser ctrl.$viewValue
			return if ctrl.$viewValue is val
			ctrl.$viewValue = val
			ctrl.$render()
		, ctrl.$options?.debounce or 2000
]

.directive 'validateNrb', ['nrb', (validator) ->
	restrict: 'A'
	require: '?ngModel'
	link: (scope, element, attrs, ctrl) ->
		return unless ctrl?

		ctrl.$validators.nrb = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or validator.validate value

]
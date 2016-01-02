'use strict'

angular.module 'touk.dowod.directives', [
	'touk.dowod.validators'
]

.directive 'validateDowod', ['dowod', (validator) ->
	restrict: 'A'
	require: '?ngModel'
	link: (scope, element, attrs, ctrl) ->
		return unless ctrl?
		ctrl.$validators.dowod = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or validator.validate value
]
'use strict'

angular.module 'touk.pesel.directives', [
	'touk.pesel.validators'
]

.directive 'validatePesel', ['pesel', (validator) ->
	restrict: 'A'
	require: 'ngModel'
	link: (scope, element, attrs, ctrl) ->
		ctrl.$validators.pesel = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or validator.validate value
]
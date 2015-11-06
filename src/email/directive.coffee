'use strict'

angular.module 'touk.email.directives', [
	'touk.email.validators'
]

.directive 'validateEmail', ['EmailValidator', (Validator) ->
	restrict: 'A'
	require: 'ngModel'
	link: (scope, element, attrs, ctrl) ->

		ctrl.$validators.email = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or new Validator().validate value

]
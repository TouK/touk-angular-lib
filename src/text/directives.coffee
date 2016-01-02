'use strict'

angular.module 'touk.text.directives', [
	'touk.text.validators'
]

.directive 'validateText', ['TextValidator', (Validator) ->
	restrict: 'A'
	require: '?ngModel'
	link: (scope, element, attrs, ctrl) ->
		return unless ctrl?

		ctrl.$validators.text = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or new Validator().validate value

]
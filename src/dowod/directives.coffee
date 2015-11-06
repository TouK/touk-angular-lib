'use strict'

angular.module 'touk.dowod.directives', [
	'touk.dowod.validators'
]

.directive 'validateDowod', ['dowod', 'HotKeysElement', (validator, HotKeys) ->
	restrict: 'A'
	require: 'ngModel'
	link: (scope, element, attrs, ctrl) ->
		ctrl.$validators.dowod = (modelValue, viewValue) ->
			value = modelValue or viewValue
			ctrl.$isEmpty(value) or validator.validate value
]
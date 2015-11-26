'use strict'

angular.module 'touk.showErrors', []

.directive 'showErrors', [
	'$timeout'
	($timeout) ->
		scope: true
		link: (scope, elm, attrs) ->
			scope.validators = []
			controllers = (
				angular.element(input).controller 'ngModel' for input in elm.find 'input, select, textarea'
			)

			addWatch = ($controller, i) ->
				scope.$watch ->
					$controller.$dirty and $controller.$invalid
				, (isInvalid) -> scope.validators[i] = isInvalid

			addWatch ctrl, i for ctrl, i in controllers

			scope.$watchCollection 'validators', (vals) ->
				return elm.addClass 'has-error' for val in vals when val
				elm.removeClass 'has-error'
]
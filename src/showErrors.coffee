'use strict'

angular.module 'touk.showErrors', []

.directive 'showErrors', ->
	scope: true
	link: (scope, elm, attrs) ->
		scope.validators = []

		getControllers = -> (
			angular.element(input).controller 'ngModel' for input in elm.find 'input, select, textarea'
		)

		scope.$watchCollection getControllers, (controllers) ->
			addWatch ctrl, i for ctrl, i in controllers

		addWatch = ($controller, i) ->
			$controller.$$hasErrorsWatch ?= scope.$watch ->
				$controller.$touched and $controller.$invalid
			, (isInvalid) -> scope.validators[i] = isInvalid

		scope.$watchCollection 'validators', (vals) ->
			return elm.addClass 'has-error' for val in vals when val
			elm.removeClass 'has-error'
'use strict'

angular.module 'touk.showErrors', []

.directive 'showErrors', ->
	scope: true
	link: (scope, elm, attrs) ->
		scope.validators = []

		getControllers = ->
			# TODO: maybe support IE8
			modelEls = elm[0].querySelectorAll '[ng-model]'
			(angular.element(input).controller 'ngModel' for input in modelEls)

		scope.$watchCollection getControllers, (controllers) ->
			addWatch ctrl, i for ctrl, i in controllers

		addWatch = ($controller, i) ->
			$controller?.$$hasErrorsWatch ?= scope.$watch ->
				$controller.$touched and $controller.$invalid
			, (isInvalid) -> scope.validators[i] = isInvalid

		scope.$watchCollection 'validators', (vals) ->
			scope.$hasErrors = _.any vals
			if scope.$hasErrors
				elm.addClass 'has-error'
				return
			elm.removeClass 'has-error'
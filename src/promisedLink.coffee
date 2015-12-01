'use strict'

class PromisedFn
	constructor: (@$element) ->

	handleClick: (event) =>
		return if (event.originalEvent or event).preventedDefault
		event.preventDefault() if @shouldPreventDefault(event)

	shouldPreventDefault: (options) =>
		returnedValue = @func()

		if typeof returnedValue is 'function'
			returnedValue = returnedValue()

		return no if returnedValue is true

		promise = returnedValue?.$promise or returnedValue
		promise = promise?.then?(=> @simulateDefault options)

		return yes if promise or not returnedValue

	simulateDefault: (options) =>
		event = document.createEvent "MouseEvents"

		event.initMouseEvent "click",
			true, true, window, 0, 0, 0, 0, 0,
			options.ctrlKey, options.altKey,
			options.shiftKey, options.metaKey,
			options.button, null

		event.preventedDefault = yes
		@$element[0].dispatchEvent event


angular.module 'touk.promisedLink', []

.controller 'PromisedFnCtrl', ['$element', PromisedFn]

.directive 'promisedFn', ->
	restrict: 'A'
	controller: 'PromisedFnCtrl as ctrl'
	bindToController:
		func: '&promisedFn'

	link: (scope, element) ->
		element.on 'click', scope.ctrl.handleClick






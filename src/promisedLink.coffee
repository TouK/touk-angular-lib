'use strict'

class PromisedFn
	@$inject: ['$element', '$attrs']
	constructor: (@$element, @$attrs) ->

	handleClick: (event) =>
		return if (event.originalEvent or event).preventedDefault
		return if @$attrs.disabled
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

.directive 'promisedFn', ->
	restrict: 'A'
	controller: PromisedFn
	controllerAs: 'ctrl'
	bindToController:
		func: '&promisedFn'

	link: (scope, element, attrs, ctrl) ->
		element.on 'click', ctrl.handleClick






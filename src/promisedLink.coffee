'use strict'

class PromisedFn
	@$inject: ['$scope','$element', '$attrs', '$q', '$timeout']
	constructor: ($scope, @$element, @$attrs, @$q, @$timeout) ->
		@$element.on 'click', @handleClick

	handleClick: (event) =>
		return if (event.originalEvent or event).preventedDefault
		return if @$attrs.disabled
		@preventDefault ?= @shouldPreventDefault(event)
		if @preventDefault
			event.preventDefault()
			event.stopPropagation()
			event.stopImmediatePropagation()

	shouldPreventDefault: (options) =>
		returnedValue = @func()

		if angular.isFunction returnedValue
			returnedValue = returnedValue()

		return no if returnedValue is true

		promise = @$q.when(returnedValue.$promise or returnedValue)
		.then => @simulateDefault options
		.finally => delete @preventDefault

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

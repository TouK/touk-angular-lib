'use strict'

class PromisedFn
	@$inject: ['$scope','$element', '$attrs', '$q', '$timeout']
	constructor: ($scope, @$element, @$attrs, @$q, @$timeout) ->
		@$element.on 'click', @handleClick

	handleClick: (event) =>
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

		@promise = @$q.when returnedValue
		.then => @simulateDefault options
		.catch => @preventDefault = null

		return yes if @promise or not returnedValue

	simulateDefault: (options) =>
		event = document.createEvent "MouseEvents"
		event.initMouseEvent "click",
			true, true, window, 0, 0, 0, 0, 0,
			options.ctrlKey, options.altKey,
			options.shiftKey, options.metaKey,
			options.button, null

		@cleanup()
		@$element[0].dispatchEvent event

	cleanup: =>
		@$element.off 'click', @handleClick

angular.module 'touk.promisedLink', []

.directive 'promisedFn', ->
	restrict: 'A'
	controller: PromisedFn
	controllerAs: 'ctrl'
	bindToController:
		func: '&promisedFn'

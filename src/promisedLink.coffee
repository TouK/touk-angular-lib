'use strict'

angular.module 'touk.promisedLink', []

.directive 'promisedFn', [
	'$timeout'
	'$parse'
	($timeout, $parse)->
		restrict: 'A'
		link: (scope, element, attrs) ->
			fnGetter = null
			options = {}

			attrs.$observe 'promisedFn', (fn) ->
				fnGetter = $parse(fn)

			simulateDefault = ->
				$timeout ->
					newEvent = document.createEvent "MouseEvents"
					newEvent.initMouseEvent "click", true, true, window, 0, 0, 0, 0, 0, options.ctrlKey, options.altKey, options.shiftKey, options.metaKey, options.button, null
					newEvent.preventedDefault = yes
					element[0].dispatchEvent newEvent

			element.on 'click', (event) ->
				return if (event.originalEvent or event).preventedDefault
				options =
					ctrlKey: event.ctrlKey
					altKey: event.altKey
					shiftKey: event.shiftKey
					metaKey: event.metaKey
					button: event.button
				if fnGetter(scope)?.then?(simulateDefault)
					event.preventDefault()
]
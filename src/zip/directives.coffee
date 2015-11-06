'use strict'

angular.module 'touk.zipcode.directives', [
	'touk.zipcode.filters'
]

.directive 'maskZipcode', ['$filter', ($filter) ->
	restrict: 'A'
	require: 'ngModel'
	link: (scope, element, attrs, ctrl) ->

		parser = (value) ->
			value?.toString()
			.replace /[^0-9]/g, ''
			.replace /(\d{2})/, '$1-'

		formatter = (value) ->
			$filter('maskZipcode') value

		ctrl.$parsers.unshift parser
		ctrl.$formatters.push formatter

		element.on 'blur paste', _.debounce ->
			val = formatter parser ctrl.$viewValue
			return if ctrl.$viewValue is val
			ctrl.$viewValue = val
			ctrl.$render()
		, ctrl.$options?.debounce or 100
]
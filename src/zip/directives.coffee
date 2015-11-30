'use strict'

angular.module 'touk.zipcode.directives', [
	'touk.zipcode.filters'
]

.directive 'maskZipcode', ['$filter', ($filter) ->
	restrict: 'A'
	require: 'ngModel'
	link: (scope, element, attrs, ctrl) ->

		formatter = (value) ->
			$filter('maskZipcode') value

		ctrl.$parsers.unshift formatter
		ctrl.$formatters.push formatter

		element.on 'blur paste', _.debounce ->
			val = formatter ctrl.$viewValue
			return if ctrl.$viewValue is val
			ctrl.$setViewValue val
			ctrl.$render()
		, ctrl.$options?.debounce or 100
]
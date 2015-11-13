'use strict'

angular.module 'touk.applyFilter', []

.run [
	'$rootScope', '$parse'
	($scope, $parse) ->
		$scope.applyFilter = (filter, value) ->
			if filter
				$parse("#{value} | #{filter}")()
			else
				value
]
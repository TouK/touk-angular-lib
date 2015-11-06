'use strict'

angular.module 'touk.zipcode.filters', []

.filter 'maskZipcode', ->
	(value) ->
		value?.toString()
		.replace /[^0-9]/g, ''
		.slice 0, 5
		.replace /(\d{2})/, '$1-'

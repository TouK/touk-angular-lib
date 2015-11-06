'use strict'

angular.module 'touk.nip.filters', []

.filter 'maskNip', ->
	(value) ->
		value?.toString()
		.replace /[^0-9]/g, ''
		.slice 0, 10
		.replace /(\d{3}(?=\d\B)|\d{2}(?=\d))/g, '$1-'

'use strict'

angular.module 'touk.nrb.filters', []

.filter 'maskNrb', ->
	(value) ->
		value?.toString()
		.replace /[^0-9]/g, ''
		.slice 0, 26
		.replace /(^\d{2}(?=\d\B)|\d{4}(?=\d))/g, '$1 '

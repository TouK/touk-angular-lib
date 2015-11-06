'use strict'

angular.module 'touk.money.filters', []

.filter 'money', ['$filter', ($filter) ->
	(quantity = 0, precision = 2, unit = ' zł') ->
		$filter('unitFloat') quantity, precision, unit
]

.filter 'unitFloat', ['$filter', ($filter) ->
	(quantity = 0, precision = 2, unit = '') ->
		return quantity if angular.isString quantity
		quantity = $filter('decimal') quantity, precision
		quantity = quantity.toFixed(precision).toString().replace(/\./, ',')
		quantity = $filter('thousandsSeparate') quantity
		"#{quantity}#{unit}".trim()
]

.filter 'decimal', ['$filter', ($filter) ->
	(quantity = 0, precision = 2) ->
		m = Math.pow 10, precision
		s = if quantity < 0 then -1 else 1
		s * (Math.round(Math.abs(quantity) * m) / m)
]

.filter 'thousandsSeparate', ->
	(quantity = 0, separator = ' ') ->
		thousandsRegex = /(\d)(?:(?=\d+(?=[^\d.]))(?=(?:\d{3})+\b)|(?=\d+(?=\.))(?=(?:\d{3})+(?=\.)))/g
		"#{quantity} ".replace(thousandsRegex, "$1#{separator}").trim()

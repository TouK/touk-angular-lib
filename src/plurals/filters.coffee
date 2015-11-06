'use strict'

angular.module 'touk.plurals.filters', [
	'smart'
]

.run [
	'SmartPlurals', (SmartPlurals) ->
		SmartPlurals.defineRule "pl_custom", (value, choices) ->
			return 0 if value is 1
			return 3 if (0 < value % 1 < 1)
			mod10 = value % 10
			mod100 = value % 100
			return 1 if (2 <= mod10 <= 4) and not (12 <= mod100 <= 14)
			return 2 if not (2 <= mod10 <= 4) or (12 <= mod100 <= 14)
			return 3

		SmartPlurals.setDefaultRule 'pl_custom'
]

.filter 'miesiace', ['$filter', ($filter) ->
	(value, withoutValue) ->
		plurals = ['miesiąc', 'miesiące', 'miesięcy', 'miesiąca']
		m = $filter('plural') value, plurals...
		if withoutValue then m
		else "#{value} #{m}"
]

.filter 'lata', ['$filter', ($filter) ->
	(value, withoutValue) ->
		plurals = ['rok', 'lata', 'lat', 'roku']
		m = $filter('plural') value, plurals...
		if withoutValue then m
		else "#{value} #{m}"
]


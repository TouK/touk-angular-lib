String::has = (subString) -> @hasSubstring subString
String::hasSubstring = (subString) ->
	Boolean @match new RegExp subString, 'gi'

String::startsWith = (subString) ->
	Boolean @indexOf(subString) is 0

String::isOnlyDigits = () -> Boolean /^\d+$/.test @



Array::has = (element) ->
	Boolean @indexOf(element) >= 0

Array::unique = ->
	_.unique @

Array::divideBy = (num) ->
	return [@] if not _.isNumber(num) or num < 2
	(el for el in @[i..] by num) for i in [0..num-1]

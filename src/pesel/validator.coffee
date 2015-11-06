'use strict'

angular.module 'touk.pesel.validators', []

.service 'pesel', class Pesel
	weights: [1, 3, 7, 9, 1, 3, 7, 9, 1, 3]

	sum: (chars) ->
		sum = 0
		for weight, i in @weights
			sum += weight * parseInt chars[i]

		sum = sum % 10
		sum = 10 - sum if sum isnt 0
		return sum

	validate: (pesel) =>
		return false unless /^\d{11}$/.test pesel
		return false unless @date pesel
#		return false if /^(.)\1{10}$/.test pesel
		chars = pesel.toString().split ''
		return true if parseInt(chars[10]) is @sum(chars)
		return false

	generate: =>
		chars = []
		for i in [0..9]
			chars[i] = Math.round Math.random()*9
		# for FINO
		chars[2] = Math.round Math.random()*1
		chars[10] = @sum chars
		pesel = chars.join ''
		if @date(pesel)
			return pesel
		else
			@generate()

	date: (pesel) =>
		chars = pesel.toString().split ''
		cent = 18 + ((Math.floor chars[2]/2)+1)%5
		yyyy = parseInt cent + chars[0] + chars[1]
		mm = parseInt chars[2]%2 + chars[3]
		dd = parseInt chars[4] + chars[5]
		if (0 < mm < 13) and (0 < dd < 32)
			return new Date yyyy, mm-1, dd
		else
			return null
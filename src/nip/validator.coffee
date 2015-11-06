'use strict'

angular.module 'touk.nip.validator', [
]

.service 'nip', class Nip
	weights: [6, 5, 7, 2, 3, 4, 5, 6, 7]

	sum: (chars) ->
		sum = 0
		for weight, i in @weights
			sum += weight * parseInt chars[i]

		return sum % 11

	clean: (nip) =>
		nip?.toString().replace /[\s-]/g, ''

	validate: (nip) =>
		nip = @clean nip
		return false if nip < 1
		return false unless /^\d{10}$/.test nip
		chars = nip.toString().split ''
		return true if parseInt(chars[9]) is @sum(chars)
		return false

	generate: =>
		chars = []
		for i in [0..8]
			chars[i] = Math.round Math.random()*9
		sum = @sum(chars)
		if sum is 10
			@generate()
		else
			chars[9] = sum
			chars.join ''

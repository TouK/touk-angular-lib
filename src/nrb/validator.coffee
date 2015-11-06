'use strict'

angular.module 'touk.nrb.validators', []

.service 'nrb', class Nrb
	weights: [1, 10, 3, 30, 9, 90, 27, 76, 81, 34, 49, 5, 50, 15, 53, 45, 62, 38, 89, 17, 73, 51, 25, 56, 75, 71, 31, 19, 93, 57]

	sum: (chars) ->
		sum = 0
		for weight, i in @weights
			sum += weight * parseInt chars[i]
		return sum % 97

	clean: (nrb) =>
		nrb?.toString().replace /[^0-9]/g, ''

	validate: (nrb) =>
		nrb = @clean nrb
		return false unless /^\d{26}$/.test nrb
		nrb = nrb.substring(2) + '2521' + nrb.substring(0, 2);
		chars = nrb.split('').reverse()
		return true if @sum(chars) is 1
		return false

	generate: =>
		chars = []
		for i in [0..25]
			chars[i] = Math.round Math.random()*9
		nrb = chars.join ''
		unless @validate nrb
			@generate()
		else nrb

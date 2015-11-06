'use strict'

angular.module 'touk.dowod.validators', []

.service 'dowod', class Dowod
	charMap:
		A: 10, B: 11, C: 12, D: 13, E: 14, F: 15
		G: 16, H: 17, I: 18, J: 19, K: 20, L: 21
		M: 22, N: 23, O: 24, P: 25, Q: 26, R: 27
		S: 28, T: 29, U: 30, V: 31, W: 32, X: 33
		Y: 34, Z: 35

	weights: [7, 3, 1, 9, 7, 3, 1, 7, 3]
	# alternatives
	# [1, 9, 3, 7, 1, 9, 3, 1, 9]
	# [3, 7, 9, 1, 3, 7, 9, 3, 7]
	# [9, 1, 7, 3, 9, 1, 7, 9, 1]

	sum: (chars) ->
		sum = 0
		for weight, i in @weights
			char = chars[i]
			if i < 3 then num = @charMap[char]
			else num = parseInt char
			sum += weight * (num or 0)
		sum = sum % 10

	validate: (dowod) =>
		return false unless /^[a-z]{3}[0-9]{6}$/i.test dowod
#		return false if /^(.)\1{2}(.)\1{5}$/.test dowod
		chars = dowod.toString().toUpperCase().split ''

		@sum(chars) is 0

	generate: =>
		chars = []
		for i in [0..7]
			if i < 3
				r = 10 + Math.round Math.random() * 15
				char = k for k, v of @charMap when r is v
			else char = (Math.round Math.random()*9).toString()
			chars[i] = char
		chars[8] = (@weights[8] * @sum(chars) % 10).toString()
		dowod = chars.join ''

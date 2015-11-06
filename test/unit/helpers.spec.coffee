'use strict'

describe 'helpers', ->

	describe 'String', ->
		string = 'Fusce interdum. Suspendisse elit semper tellus. Curabitur nec adipiscing sapien.'

		it 'has substring', ->
			expect(string.has 'elit').toBeTruthy()
			expect(string.has 'xxxx').not.toBeTruthy()
			expect(string.hasSubstring 'elit').toBeTruthy()
			expect(string.hasSubstring 'xxxx').not.toBeTruthy()

		it 'starts with string', ->
			expect(string.startsWith 'Fusce interdum').toBeTruthy()
			expect(string.startsWith 'Fusce xxx interdum').not.toBeTruthy()

		it 'has only digits', ->
			expect('1234567890'.isOnlyDigits()).toBeTruthy()
			expect('123 456 789 0'.isOnlyDigits()).not.toBeTruthy()
			expect('abc123'.isOnlyDigits()).not.toBeTruthy()
			expect('123.456'.isOnlyDigits()).not.toBeTruthy()

	describe 'Array', ->
		array = [1,2,3,4,4]

		it 'has element', ->
			expect(array.has 1).toBeTruthy()
			expect(array.has 0).not.toBeTruthy()
			expect(array.has '1').not.toBeTruthy()

		it 'unique', ->
			expect(array.unique()).toEqual [1,2,3,4]
			expect([].unique()).toEqual []

		it 'every n steps divide to n Arrays', ->
			expect(array.divideBy()).toEqual [array]
			expect(array.divideBy 0).toEqual [array]
			expect(array.divideBy 2).toEqual [[1,3,4],[2,4]]
			expect(array.divideBy 6).toEqual [[1],[2],[3],[4],[4],[]]


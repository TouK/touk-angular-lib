'use strict'

describe 'Zip code', ->

	describe 'filter', ->

		beforeEach ->
			module 'touk.zipcode.filters'

		it 'should be defined', inject ($filter) ->
			expect($filter 'maskZipcode').not.toBeNull()

		filter = null

		beforeEach ->
			inject (maskZipcodeFilter) -> filter = maskZipcodeFilter

		it 'should ignore empty', ->
			expect(filter()).toBe undefined
			expect(filter undefined).toBe undefined
			expect(filter null).toBe undefined

		it 'should give valid form', ->
			expect(filter 11323).toBe '11-323'
			expect(filter 1132334343).toBe '11-323'
			expect(filter '11323').toBe '11-323'
			expect(filter '113asd233asd43asd43').toBe '11-323'

'use strict'

describe 'Plurals', ->
	beforeEach ->
		module 'touk.plurals.filters'

	describe 'miesiace', ->

		it 'should be defined', inject ($filter) ->
			expect($filter 'miesiace').not.toBeNull()

		filter = null

		beforeEach ->
			inject (miesiaceFilter) -> filter = miesiaceFilter

		it 'should give valid form', ->
			expect(filter 0).toBe '0 miesięcy'
			expect(filter 1).toBe '1 miesiąc'
			expect(filter 2).toBe '2 miesiące'
			expect(filter 5).toBe '5 miesięcy'
			expect(filter 21).toBe '21 miesięcy'
			expect(filter 52).toBe '52 miesiące'
			expect(filter 52.5).toBe '52.5 miesiąca'
			expect(filter 121).toBe '121 miesięcy'
			expect(filter 122).toBe '122 miesiące'

	describe 'lata', ->

		it 'should be defined', inject ($filter) ->
			expect($filter 'lata').not.toBeNull()

		filter = null

		beforeEach ->
			inject (lataFilter) -> filter = lataFilter

		it 'should give valid form', ->
			expect(filter 0).toBe '0 lat'
			expect(filter 1).toBe '1 rok'
			expect(filter 2).toBe '2 lata'
			expect(filter 5).toBe '5 lat'
			expect(filter 21).toBe '21 lat'
			expect(filter 52).toBe '52 lata'
			expect(filter 52.5).toBe '52.5 roku'
			expect(filter 121).toBe '121 lat'
			expect(filter 122).toBe '122 lata'

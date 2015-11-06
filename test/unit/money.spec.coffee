'use strict'

describe 'Money', ->

	describe 'filter', ->
		beforeEach ->
			module 'touk.money.filters'

		it 'helpers should be defined', inject ($filter) ->
			expect($filter 'decimal').not.toBeNull()
			expect($filter 'unitFloat').not.toBeNull()
			expect($filter 'thousandsSeparate').not.toBeNull()

		it 'should be defined', inject ($filter) ->
			expect($filter 'money').not.toBeNull()

		filter = null

		beforeEach ->
			inject (moneyFilter) -> filter = moneyFilter

		it 'should give 0 for invalid amount', ->
			expect(filter()).toBe '0,00 zł'
			expect(filter null).toBe '0,00 zł'
			expect(filter undefined).toBe '0,00 zł'

		it 'should give right amount for simple value', ->
			expect(filter 0).toBe '0,00 zł'
			expect(filter 10).toBe '10,00 zł'
			expect(filter 12.56).toBe '12,56 zł'
			expect(filter 12.564).toBe '12,56 zł'
			expect(filter 12.565).toBe '12,57 zł'

		it 'should give right amount for negative value', ->
			expect(filter -10).toBe '-10,00 zł'
			expect(filter -12.565).toBe '-12,57 zł'
			expect(filter -1000).toBe '-1 000,00 zł'
			expect(filter -100000).toBe '-100 000,00 zł'

		it 'should not touch amount in string', ->
			expect(filter '12.56').toBe '12.56'
			expect(filter '17,53').toBe '17,53'
			expect(filter '17,53', 'USD').toBe '17,53'

		it 'should handle precision', ->
			expect(filter 1, 3).toBe '1,000 zł'
			expect(filter 1.5, 0).toBe '2 zł'

		it 'should handle unit', ->
			expect(filter 1, 2).toBe '1,00 zł'
			expect(filter 2, 2, '').toBe '2,00'
			expect(filter 3, 2, ' PLN').toBe '3,00 PLN'
			expect(filter 3, 2, undefined).toBe '3,00 zł'
			expect(filter 4, 2, ' €').toBe '4,00 €'
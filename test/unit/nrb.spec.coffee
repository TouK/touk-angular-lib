'use strict'

describe 'Bank account number', ->

	describe 'filter', ->

		beforeEach ->
			module 'touk.nrb.filters'

		it 'should be defined', inject ($filter) ->
			expect($filter 'maskNrb').not.toBeNull()

		filter = null

		beforeEach ->
			inject (maskNrbFilter) -> filter = maskNrbFilter

		it 'should ignore empty', ->
			expect(filter()).toBe undefined
			expect(filter undefined).toBe undefined
			expect(filter null).toBe undefined

		it 'should give valid form', ->
			expect(filter '12312321123123213213213213213123213123121323123213').toBe '12 3123 2112 3123 2132 1321 3213'
			expect(filter '11323').toBe '11 323'
			expect(filter '113asd233asd43asd43').toBe '11 3233 4343'
			expect(filter 'PL 03 1500 0000 6417 6088 6520 6308').toBe '03 1500 0000 6417 6088 6520 6308'
			expect(filter 'PL03150000006417608865206308').toBe '03 1500 0000 6417 6088 6520 6308'


	describe 'validators', ->
		service = null

		beforeEach ->
			module 'touk.nrb.validators'
			inject (nrb) -> service = nrb

		it 'validator should be defined', ->
			expect(service).not.toBeNull()
			expect(service.validate).not.toBeNull()

		it 'should pass valid string', ->
			expect(service.validate 'PL 66 8303 0006 2460 6186 9233 3363').toBeTruthy()
			expect(service.validate 'PL 89 8530 0000 8885 5361 1008 2193').toBeTruthy()
			expect(service.validate 'PL26124013437840437785961114').toBeTruthy()
			expect(service.validate '34 8119 0001 1648 9584 3478 7013').toBeTruthy()
			expect(service.validate '65-1240-6162-4607-3156-3608-1451').toBeTruthy()
			expect(service.validate '5510 5017 5160 2356 4329 6809 62').toBeTruthy()
			expect(service.validate '49109025743517985585159868').toBeTruthy()
			expect(service.validate '94102051706743445141433700').toBeTruthy()
			expect(service.validate '27161012507220723838151687').toBeTruthy()

		it 'should drop empty', ->
			expect(service.validate()).toBeFalsy()
			expect(service.validate undefined).toBeFalsy()
			expect(service.validate null).toBeFalsy()
			expect(service.validate '').toBeFalsy()

		it 'should drop non digit', ->
			expect(service.validate 'abcdefghijk').toBeFalsy()

		it 'should drop invalid', ->
			expect(service.validate 0).toBeFalsy()
			expect(service.validate 'PL 03 1500 0000 6417 6088 6520 6308').toBeFalsy()
			expect(service.validate '00000000000000000000000000').toBeFalsy()

		it 'should drop wrong length', ->
			expect(service.validate '9410205170674344514143370').toBeFalsy()
			expect(service.validate '941020517067434451414337000').toBeFalsy()

		it 'should have generator', ->
			expect(service.generate).not.toBeNull()
			expect(service.generate()).not.toBeNull()

		it 'should generate valid', ->
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
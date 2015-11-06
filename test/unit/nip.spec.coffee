'use strict'

describe 'NIP', ->

	describe 'filter', ->

		beforeEach ->
			module 'touk.nip.filters'

		it 'should be defined', inject ($filter) ->
			expect($filter 'maskNip').not.toBeNull()

		filter = null

		beforeEach ->
			inject (maskNipFilter) -> filter = maskNipFilter

		it 'should ignore empty', ->
			expect(filter()).toBe undefined
			expect(filter undefined).toBe undefined
			expect(filter null).toBe undefined

		it 'should give valid form', ->
			expect(filter 1132334343).toBe '113-233-43-43'
			expect(filter '1132334343').toBe '113-233-43-43'
			expect(filter '113asd233asd43asd43').toBe '113-233-43-43'
			expect(filter '113-233-43-43').toBe '113-233-43-43'
			expect(filter '113-23-34-343132213').toBe '113-233-43-43'

	describe 'validator', ->
		service = null

		beforeEach ->
			module 'touk.nip.validator'
			inject (nip) -> service = nip

		it 'should be defined', ->
			expect(service).not.toBeNull()
			expect(service.validate).not.toBeNull()

		it 'should pass valid string', ->
			expect(service.validate '168-504-46-15').toBeTruthy()
			expect(service.validate '865 042 40 39').toBeTruthy()
			expect(service.validate '311-97-85-577').toBeTruthy()
			expect(service.validate '269 47 63 913').toBeTruthy()
			expect(service.validate '5649979304').toBeTruthy()

		it 'should pass valid number', ->
			expect(service.validate 4646690790).toBeTruthy()
			expect(service.validate 1751564212).toBeTruthy()

		it 'should drop empty', ->
			expect(service.validate()).toBeFalsy()
			expect(service.validate undefined).toBeFalsy()
			expect(service.validate null).toBeFalsy()
			expect(service.validate '').toBeFalsy()

		it 'should drop non digit', ->
			expect(service.validate 'abcdefghijk').toBeFalsy()

		it 'should drop invalid', ->
			expect(service.validate '-').toBeFalsy()
			expect(service.validate 'sadas').toBeFalsy()
			expect(service.validate 0).toBeFalsy()
			expect(service.validate '0000000000').toBeFalsy()
			expect(service.validate 1234567890).toBeFalsy()

		it 'should drop wrong length', ->
			expect(service.validate 760419158).toBeFalsy()
			expect(service.validate 76041915891).toBeFalsy()

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
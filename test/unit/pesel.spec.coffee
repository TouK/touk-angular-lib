'use strict'

describe 'PESEL', ->
	describe 'validator', ->
		beforeEach ->
			module 'touk.pesel.validators'

		service = null

		beforeEach ->
			inject (pesel) -> service = pesel

		it 'should be defined', ->
			expect(service).not.toBeNull()
			expect(service.validate).not.toBeNull()

		it 'should pass valid string', ->
			expect(service.validate '04222107503').toBeTruthy()
			expect(service.validate '84030702820').toBeTruthy()

		it 'should pass valid number', ->
			expect(service.validate 55011002217).toBeTruthy()
			expect(service.validate 76041915849).toBeTruthy()

		it 'should drop empty', ->
			expect(service.validate()).toBeFalsy()
			expect(service.validate undefined).toBeFalsy()
			expect(service.validate null).toBeFalsy()
			expect(service.validate '').toBeFalsy()

		it 'should drop non digit', ->
			expect(service.validate 'abcdefghijk').toBeFalsy()

		it 'should drop same digits', ->
			expect(service.validate '00000000000').toBeFalsy()
			expect(service.validate '99999999999').toBeFalsy()
			expect(service.validate 99999999999).toBeFalsy()

		it 'should drop invalid', ->
			expect(service.validate 12345678901).toBeFalsy()
			expect(service.validate 66977341915).toBeFalsy()

		it 'should drop wrong length', ->
			expect(service.validate 7604191584).toBeFalsy()
			expect(service.validate 760419158491).toBeFalsy()

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
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()
			expect(service.validate service.generate()).toBeTruthy()

		it 'should have birth date reader', ->
			expect(service.date).not.toBeNull()

		it 'should get birth date', ->
			expect(service.date 84901800000).toEqual new Date 1884, 9, 18
			expect(service.date 84101800000).toEqual new Date 1984, 9, 18
			expect(service.date 84301800000).toEqual new Date 2084, 9, 18
			expect(service.date 84501800000).toEqual new Date 2184, 9, 18
			expect(service.date 84701800000).toEqual new Date 2284, 9, 18
'use strict'

describe 'Polish identity card', ->
	beforeEach ->
		module 'touk.dowod.validators'

	describe 'validator', ->

		it 'should be defined', inject (dowod) ->
			expect(dowod).not.toBeNull()
			expect(dowod.validate).not.toBeNull()

		it 'should pass valid string', inject (dowod) ->
			expect(dowod.validate 'ABA300000').toBeTruthy()
			expect(dowod.validate 'AVH537160').toBeTruthy()

		it 'should be case insensitive', inject (dowod) ->
			expect(dowod.validate 'aky568902').toBeTruthy()
			expect(dowod.validate 'avd704036').toBeTruthy()

		it 'should drop empty', inject (dowod) ->
			expect(dowod.validate undefined).toBeFalsy()
			expect(dowod.validate undefined).toBeFalsy()
			expect(dowod.validate null).toBeFalsy()
			expect(dowod.validate '').toBeFalsy()

		it 'should drop only digits', inject (dowod) ->
			expect(dowod.validate '123123123').toBeFalsy()

		it 'should drop only chars', inject (dowod) ->
			expect(dowod.validate 'ABCDEFGHI').toBeFalsy()

		it 'should drop invalid', inject (dowod) ->
			expect(dowod.validate 'xyz123456').toBeFalsy()
			expect(dowod.validate 'AB3000000').toBeFalsy()
			expect(dowod.validate 'ABAA30000').toBeFalsy()

		it 'should drop wrong length', inject (dowod) ->
			expect(dowod.validate 'ABA3000000').toBeFalsy()
			expect(dowod.validate 'ABA30000').toBeFalsy()

		it 'should have generator', inject (dowod) ->
			expect(dowod.generate).not.toBeNull()
			expect(dowod.generate()).not.toBeNull()

		it 'should generate valid', inject (dowod) ->
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()
			expect(dowod.validate dowod.generate()).toBeTruthy()

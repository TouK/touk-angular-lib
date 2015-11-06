'use strict'

describe 'Email', ->
	beforeEach ->
		module 'touk.email.validators'

	describe 'validator', ->
		service = null

		beforeEach ->
			inject (EmailValidator) -> service = new EmailValidator()

		it 'should be defined', ->
			expect(service).not.toBeNull()
			expect(service.validate).not.toBeNull()

		it 'should drop empty', ->
			expect(service.validate undefined).toBeFalsy()
			expect(service.validate null).toBeFalsy()
			expect(service.validate '').toBeFalsy()

		it 'should pass valid', ->
			expect(service.validate 'a@a.a').toBeTruthy()
			expect(service.validate 'aa_aa@aaaa.aa').toBeTruthy()
			expect(service.validate 'aa-aa@aa-aa.aa').toBeTruthy()
			expect(service.validate 'aa+aa@aaaa.aa').toBeTruthy()
			expect(service.validate 'aa.aa@aa.aa.aa').toBeTruthy()
			expect(service.validate 'Aa.Aa@Aa.Aa.aa').toBeTruthy()
			expect(service.validate 'aa1.aa1@aa2.aa2.aa2').toBeTruthy()

		it 'should drop invalid', ->
			expect(service.validate 'aaaa@aa+aa.aa').toBeFalsy()
			expect(service.validate 'aaaa@aa_aa.aa').toBeFalsy()
			expect(service.validate 'asdsas').toBeFalsy()
			expect(service.validate 'asd.sas').toBeFalsy()
			expect(service.validate 'asd.sas@').toBeFalsy()
			expect(service.validate 'asd.sas@asdsa').toBeFalsy()
			expect(service.validate '.sdasda@asdsa').toBeFalsy()
			expect(service.validate 'sdasda.@asdsa').toBeFalsy()
			expect(service.validate 'sdasda@asdsa.').toBeFalsy()
			expect(service.validate 'sdasda@.asdsa').toBeFalsy()
			expect(service.validate '@asdsa.com').toBeFalsy()
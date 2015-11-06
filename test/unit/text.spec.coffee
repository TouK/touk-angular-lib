'use strict'

describe 'String validator', ->
	beforeEach ->
		module 'touk.text.validators'

	describe 'text', ->
		service = null

		beforeEach ->
			inject (TextValidator) -> service = new TextValidator()

		it 'should be defined', ->
			expect(service).not.toBeNull()
			expect(service.validate).not.toBeNull()

		it 'should pass polish string', ->
			expect(service.validate 'zażółć żółwią JaŹń').toBeTruthy()

		it 'should pass german string', ->
			expect(service.validate "Wer reitet so spät durch Nacht und Wind Es ist der Vater mit seinem Kind Er hat den Knaben wohl in dem Arm Er faßt ihn sicher er hält ihn warm").toBeTruthy()

		it 'should pass french string', ->
			expect(service.validate "C'est comme ça depuis que le monde tourne Y a rien à faire pour y changer C'est comme ça depuis que le monde tourne Et il vaut mieux pas y toucher").toBeTruthy()

		it 'should pass czech string', ->
			expect(service.validate "Inspektorská zahrádka je v prdeli").toBeTruthy()

		it 'should pass special', ->
			expect(service.validate "blab@la-asd\/%&_-+=[]*?!sa, das.").toBeTruthy()

		it 'should pass empty', ->
			expect(service.validate undefined).toBeTruthy()
			expect(service.validate null).toBeTruthy()
			expect(service.validate '').toBeTruthy()

		it 'should drop invalid', ->
			expect(service.validate 'adsdassa0000000000').toBeFalsy()
			expect(service.validate 'aa1').toBeFalsy()
			expect(service.validate 'aa1a').toBeFalsy()
			expect(service.validate 'aa1aa').toBeFalsy()
			expect(service.validate '()12!@#@!#@!').toBeFalsy()
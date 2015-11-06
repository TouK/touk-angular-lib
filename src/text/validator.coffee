'use strict'



angular.module 'touk.text.validators', []

.factory 'DefaultValidator', ->
	class DefaultValidator

		constructor: ->
			@polish = "ąćęłńóśźż"
			@german = "äéöüß"
			@czech = "áčďéěíňóřšťúžýů"
			@french = "'àâæçèéêëîïôùûü"
			@digits = "0-9"
			@special = " \\[\\]@%&\*#()=_+\\-/\\\\:;<>,.?!„”‘'`\""
			@letters = "a-z"+@polish+@german+@czech+@french

			@regex = "[^#{@letters}#{@digits}#{@special}]"

		validate: (text) =>
			re = new RegExp @regex, 'i'
			return false if re.test(text)
			return true

		clean: (text) =>
			re = new RegExp @regex, 'ig'
			text = text?.replace re, ''

.factory 'TextValidator', ['DefaultValidator', (DefaultValidator) ->
	class TextValidator extends DefaultValidator
		constructor: ->
			super()
			@regex = "[^#{@letters}#{@special}]"
]
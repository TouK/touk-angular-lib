'use strict'

class LocaleService
	constructor: (@$translate, $rootScope, tmhDynamicLocale, LOCALES) ->
		{@localesObj, @preferredLocale} = LOCALES
		@locales = _.keys @localesObj
		@localesNames = _.values @localesObj

		unless _.size @locales
			console.error """
				There are no locales provided.
				Define "LOCALES" value.
			"""

		@currentLocale = @$translate.proposedLanguage()

		$rootScope.$on '$translateChangeSuccess', (event, data) ->
			document.documentElement.setAttribute 'lang', data.language
			tmhDynamicLocale.set data.language.toLowerCase().replace /_/g, '-'

		@setLocale LOCALES.preferredLocale

	checkLocaleIsValid: (locale) =>
		@locales.indexOf(locale) isnt -1

	setLocale: (locale) =>
		unless @checkLocaleIsValid locale
			console.error "Locale name \"#{locale}\" is invalid'"

		@currentLocale = locale
		@$translate.use locale

	getLocaleDisplayName: =>
		@localesObj[@currentLocale]

	setLocaleByDisplayName: (localeDisplayName) =>
		@setLocale @locales[@localesNames.indexOf localeDisplayName]

	getLocalesDisplayNames: =>
		@localesNames
angular.module 'touk.locale.service', [
	'pascalprecht.translate'
	'tmh.dynamicLocale'
]

.provider 'LocaleService', ->
	new class LocaleServiceProvider
		LOCALES: ''

		$get: [
			'$translate', '$rootScope', 'tmhDynamicLocale'
			-> new LocaleService(arguments..., LOCALES)
		]

'use strict'

class LocaleService
	constructor: (@$translate, $rootScope, tmhDynamicLocale, LOCALES) ->
		{@locales, @preferredLocale} = LOCALES

		unless _.size @locales
			console.error """
				There are no locales provided.
				Define "LOCALES" value.
			"""

		@currentLocale = @$translate.proposedLanguage()

		$rootScope.$on '$translateChangeSuccess', (event, data) ->
			document.documentElement.setAttribute 'lang', data.language
			tmhDynamicLocale.set data.language.toLowerCase().replace /_/g, '-'

		@setLocale @preferredLocale

	checkLocaleIsValid: (locale) =>
		_.has @locales, locale

	setLocale: (locale) =>
		unless @checkLocaleIsValid locale
			console.error "Locale name \"#{locale}\" is invalid'"

		@currentLocale = locale
		@$translate.use locale

	getLocaleDisplayName: =>
		@locales[@currentLocale]

	setLocaleByDisplayName: (localeDisplayName) =>
		@setLocale _.findKey @locales, _.matches localeDisplayName

	getLocalesDisplayNames: => _.values @locales

angular.module 'touk.locale.service', [
	'pascalprecht.translate'
	'tmh.dynamicLocale'
]

.provider 'LocaleService', ->
	new class LocaleServiceProvider
		$get: [
			'$translate', '$rootScope', 'tmhDynamicLocale'
			-> new LocaleService(arguments..., @LOCALES)
		]

.run [
	'LocaleService', (LocaleService) ->
		# inject of LocaleService required when directive is not used
]

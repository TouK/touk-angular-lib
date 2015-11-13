'use strict'
angular.module 'touk.locale.service', [
	'pascalprecht.translate'
	'tmh.dynamicLocale'
]

.service 'LocaleService', [
	'$translate', 'LOCALES', '$rootScope', 'tmhDynamicLocale'
	class LocaleService
		constructor: (@$translate, LOCALES, $rootScope, tmhDynamicLocale) ->
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
				tmhDynamicLocale.set data.language.toLowerCase().replace /-/g, '_'

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
]
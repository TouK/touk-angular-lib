'use strict'

angular.module 'touk.locale.directive', [
	'touk.locale.service'
]

.directive 'languageChangeSelect', ->
	restrict: 'EA'
	templateUrl: "/templates/locale/languageSelect.html"
	controller: [
		'LocaleService', '$scope'
		class LanguageSelect
			constructor: (@$service, $scope) ->
				@currentLocaleDisplayName = @$service.getLocaleDisplayName()
				@localesDisplayNames = @$service.getLocalesDisplayNames()

			changeLanguage: (@currentLocaleDisplayName) =>
				@$service.setLocaleByDisplayName @currentLocaleDisplayName
	]
	controllerAs: 'LSC'
	scope: {}
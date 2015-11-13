'use strict'

angular.module 'touk.locale.directive', [
	'touk.locale.service'
]

.directive 'languageChangeSelect', ->
	restrict: 'EA'
	template: """
		<select
			ng-model="LSC.currentLocaleDisplayName"
			ng-options="name for name in LSC.localesDisplayNames"
			ng-change="LSC.changeLanguage()"
		></select>
	"""
	controller: [
		'LocaleService', '$scope'
		class LanguageSelect
			constructor: (@$service, $scope) ->
				@currentLocaleDisplayName = @$service.getLocaleDisplayName()
				@localesDisplayNames = @$service.getLocalesDisplayNames()

			changeLanguage: (@currentLocaleDisplayName = @currentLocaleDisplayName) =>
				@$service.setLocaleByDisplayName @currentLocaleDisplayName
	]
	controllerAs: 'LSC'
	scope: {}
#http://www.bennadel.com/blog/2597-preloading-images-in-angularjs-with-promises.htm

'use strict'

class Preloader
	states:
		PENDING: 1
		LOADING: 2
		RESOLVED: 3
		REJECTED: 4

	constructor: ($q, @$rootScope) ->
		@deferred = $q.defer()
		@promise = @deferred.promise
		@loadCount = 0
		@errorCount = 0
		@state = @states.PENDING

	isInitiated: => @state isnt @states.PENDING
	isRejected:  => @state is   @states.REJECTED
	isResolved:  => @state is   @states.RESOLVED

	load: (@locations) => 
		unless @isInitiated()
			@state = @states.LOADING
			@loadImageLocation location for location in @locations

		return @promise
	
	handleImageError: (location) =>
		@errorCount++

		return if @isRejected()

		@state = @states.REJECTED
		@deferred.reject location

	handleImageLoad: (location) =>
		@loadCount++

		return if @isRejected()

		@deferred.notify
			progress: Math.ceil @loadCount / @locations.length * 100
			location: location

		if @loadCount is @locations.length
			@state = @states.RESOLVED
			@deferred.resolve @locations

	loadImageLocation: (location) =>
		angular.element new Image
		.on 'load', (event) => @$rootScope.$apply => @handleImageLoad event.target.src
		.on 'error', (event) => @$rootScope.$apply => @handleImageError event.target.src
		.prop 'src', location




PreloaderFactory = (injected...) ->
	preloadImages: (locations) ->
		loader = new Preloader injected...
		loader.load locations

PreloaderFactory.$inject = ['$q', '$rootScope']




angular.module 'touk.imagePreloader', []
.factory 'ImagePreloader', PreloaderFactory
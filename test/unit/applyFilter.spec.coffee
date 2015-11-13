'use strict'

describe 'applyFilter', ->
	beforeEach ->
		module 'touk.applyFilter'

	scope = null
	filter = null

	beforeEach ->
		inject ($rootScope, $filter) ->
			scope = $rootScope.$new()
			filter = $filter

	it 'should be defined', ->
		expect(scope.applyFilter).not.toBeNull()

	it 'should return filtered value', ->
		value = 1.2345
		filterString = 'currency'
		expect(scope.applyFilter filterString, value).toBe filter(filterString) value
		expect(scope.applyFilter "#{filterString}:2", value).toBe filter(filterString) value, 2

	it 'should handle empty value', ->
		filterString = 'currency'
		expect(scope.applyFilter filterString).toBe filter(filterString)()
		expect(scope.applyFilter filterString, null).toBe filter(filterString)(null)
		expect(scope.applyFilter filterString, undefined).toBe filter(filterString)(undefined)

	it 'should handle empty filter', ->
		value = 1
		expect(scope.applyFilter '', value).toBe value
		expect(scope.applyFilter null, value).toBe value
		expect(scope.applyFilter undefined , value).toBe value

describe 'promisedLink directive', ->
	beforeEach ->
		browser.get '/test.html'

	it "should follow link for 'true'", ->
		element(By.id 'promised-fn_true').click()
		expect(browser.getCurrentUrl()).toMatch 'next'

	it "should ignore link for 'false'", ->
		element(By.id 'promised-fn_false').click()
		expect(browser.getCurrentUrl()).toMatch 'test'

	it 'should ignore link for empty', ->
		element(By.id 'promised-fn_empty').click()
		expect(browser.getCurrentUrl()).toMatch 'test'

	it 'should ignore link for undefined', ->
		element(By.id 'promised-fn_undefined').click()
		expect(browser.getCurrentUrl()).toMatch 'test'

	it 'should call function and use returned value', ->
		element(By.id 'promised-fn_function-false').click()
		expect(browser.getCurrentUrl()).toMatch 'test'
		element(By.id 'promised-fn_function-true').click()
		expect(browser.getCurrentUrl()).toMatch 'next'

	it 'should detect and call function and use returned value', ->
		element(By.id 'promised-fn_detect-function-false').click()
		expect(browser.getCurrentUrl()).toMatch 'test'
		element(By.id 'promised-fn_detect-function-true').click()
		expect(browser.getCurrentUrl()).toMatch 'next'

	it 'should follow link for resolved promise', ->
		element(By.id 'promised-fn_promise-resolve').click()
		browser.sleep 200
		expect(browser.getCurrentUrl()).toMatch 'next'

	it 'should ignore link for rejected promise', ->
		element(By.id 'promised-fn_promise-reject').click()
		browser.sleep 200
		expect(browser.getCurrentUrl()).toMatch 'test'

	it 'should follow link for done resource', ->
		element(By.id 'promised-fn_resource-done').click()
		browser.sleep 200
		expect(browser.getCurrentUrl()).toMatch 'next'

	it 'should ignore link for failed resource', ->
		element(By.id 'promised-fn_resource-failed').click()
		browser.sleep 200
		expect(browser.getCurrentUrl()).toMatch 'test'

	it 'should call resource and follow link on success', ->
		element(By.id 'promised-fn_call-resource-success').click()
		browser.sleep 200
		expect(browser.getCurrentUrl()).toMatch 'next'

	it 'should call resource and ignore link on fail', ->
		element(By.id 'promised-fn_call-resource-fail').click()
		browser.sleep 200
		expect(browser.getCurrentUrl()).toMatch 'test'
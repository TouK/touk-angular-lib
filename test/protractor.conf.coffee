exports.config =
	# Spec patterns are relative to the location of this config.
	suites:
		app: 'e2e/src/**/*.coffee'

	capabilities:
		browserName: 'chrome'
		acceptSslCerts: yes

	baseUrl: 'http://localhost:3334/cms/'

	rootElement: 'html'

	framework: 'jasmine'

	jasmineNodeOpts:
		defaultTimeoutInterval: 30000
exports.config =
	# Spec patterns are relative to the location of this config.
	specs: [
		'e2e/**/*.coffee'
	]

	capabilities:
		browserName: 'chrome'

	baseUrl: 'http://localhost:8834'

	framework: 'jasmine'

	jasmineNodeOpts:
		defaultTimeoutInterval: 30000
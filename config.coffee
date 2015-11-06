exports.config =
# See docs at http://brunch.readthedocs.org/en/latest/config.html.
	conventions:
		ignored: /^((.*\.spec\.(coffee|js))|(.*?[\/\\])?[_]\w*)/
	modules:
		definition: false
		wrapper: false
	paths:
		public: 'dist'
		watched: ['src', 'vendor']
	files:
		javascripts:
			joinTo:
				'js/app.js': /^src/
				'js/vendor.js': /^(bower_components|vendor)/
			order:
				before: [
					'bower_components/jquery/dist/jquery.js'
					'bower_components/underscore/underscore.js'
				]

	overrides:
		production:
			optimize: true
			sourceMaps: true

	server:
		port: 8834
		base: '/'
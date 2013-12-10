path = require 'path'
helpers = require('yeoman-generator').test

describe 'hipchat-addon generator', ->
  beforeEach (done) ->
    helpers.testDirectory path.join(__dirname, 'temp'), (err) =>
      if err
        return done(err)

      @app = helpers.createGenerator('hipchat-addon:app', [
        '../../app'
      ])
      done()

  it 'creates expected files', (done) ->
    expected = [
      # add files you expect to exist here.
      '.pryrc'
      '.ruby-gemset'
      '.ruby-version'
      'config.ru'
      'Gemfile'
      'lib/api.rb'
      'lib/app.rb'
      'lib/exceptions.rb'
      'lib/web.rb'
      'lib/models/account.rb'
    ]

    helpers.mockPrompt @app,
      'appName': 'testApp'
      'useRvm': true
      'templatingLanguage': 'erb'
      'availability': 'stripe'

    @app.options['skip-install'] = true
    @app.run {}, ->
      helpers.assertFiles(expected)
      done()

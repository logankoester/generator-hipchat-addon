(function() {
  var helpers, path;

  path = require('path');

  helpers = require('yeoman-generator').test;

  describe('hipchat-addon generator', function() {
    beforeEach(function(done) {
      return helpers.testDirectory(path.join(__dirname, 'temp'), (function(_this) {
        return function(err) {
          if (err) {
            return done(err);
          }
          _this.app = helpers.createGenerator('hipchat-addon:app', ['../../app']);
          return done();
        };
      })(this));
    });
    return it('creates expected files', function(done) {
      var expected;
      expected = ['.pryrc', '.ruby-gemset', '.ruby-version', 'config.ru', 'Gemfile', 'lib/api.rb', 'lib/app.rb', 'lib/exceptions.rb', 'lib/web.rb', 'lib/models/account.rb'];
      helpers.mockPrompt(this.app, {
        'appName': 'testApp',
        'useRvm': true,
        'templatingLanguage': 'erb',
        'availability': 'stripe'
      });
      this.app.options['skip-install'] = true;
      return this.app.run({}, function() {
        helpers.assertFiles(expected);
        return done();
      });
    });
  });

}).call(this);

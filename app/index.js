(function() {
  var HipchatAddonGenerator, path, yeoman,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  path = require('path');

  yeoman = require('yeoman-generator');

  module.exports = HipchatAddonGenerator = (function(_super) {
    __extends(HipchatAddonGenerator, _super);

    function HipchatAddonGenerator(args, options, config) {
      yeoman.generators.Base.apply(this, arguments);
      this.on('end', function() {
        if (!options['skip-install']) {
          return this.spawnCommand('bundle', ['install']);
        }
      });
      this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
    }

    HipchatAddonGenerator.prototype.askFor = function() {
      var cb, prompts,
        _this = this;
      cb = this.async();
      prompts = [
        {
          type: 'input',
          name: 'appName',
          message: 'Add-on name',
          "default": 'MyAddon'
        }, {
          type: 'confirm',
          name: 'useRvm',
          message: 'Generate dotfiles for RVM?',
          "default": true
        }, {
          type: 'list',
          name: 'availability',
          message: 'How will you make this add-on available?',
          choices: [
            {
              name: 'Available for free',
              value: 'free'
            }, {
              name: 'Sold through my Stripe account',
              value: 'stripe'
            }
          ],
          "default": 'stripe'
        }, {
          type: 'input',
          name: 'vendorName',
          message: 'Vendor name (your name or organization)'
        }, {
          type: 'input',
          name: 'vendorUrl',
          message: 'Vendor URL'
        }, {
          type: 'input',
          name: 'appDescription',
          message: 'Brief description'
        }, {
          type: 'input',
          name: 'appKey',
          message: 'com.myapp'
        }
      ];
      return this.prompt(prompts, function(props) {
        _this.useRvm = props.useRvm;
        _this.appName = props.appName;
        _this.availability = props.availability;
        _this.vendorUrl = props.vendorUrl;
        _this.vendorName = props.vendorName;
        _this.appDescription = props.appDescription;
        _this.appKey = props.appKey;
        return cb();
      });
    };

    HipchatAddonGenerator.prototype.app = function() {
      this.template('_pryrc', '.pryrc');
      this.template('_config.ru', 'config.ru');
      this.template('_Gemfile', 'Gemfile');
      if (this.useRvm) {
        this.template('_ruby-gemset', '.ruby-gemset');
        this.template('_ruby-version', '.ruby-version');
      }
      this.mkdir('lib');
      this.template('lib/_api.rb', 'lib/api.rb');
      this.template('lib/_app.rb', 'lib/app.rb');
      this.template('lib/_exceptions.rb', 'lib/exceptions.rb');
      this.template('lib/_web.rb', 'lib/web.rb');
      this.mkdir('lib/models');
      this.template('lib/models/_account.rb', 'lib/models/account.rb');
      this.mkdir('lib/views');
      this.template('lib/views/_configure.haml', 'lib/views/configure.haml');
      this.template('lib/views/_index.haml', 'lib/views/index.haml');
      this.template('lib/views/_layout.haml', 'lib/views/layout.haml');
      this.template('lib/views/_support.haml', 'lib/views/support.haml');
      this.template('lib/views/_thanks.haml', 'lib/views/thanks.haml');
      if (this.availability === 'stripe') {
        return this.template('lib/views/_charge.haml', 'lib/views/charge.haml');
      }
    };

    return HipchatAddonGenerator;

  })(yeoman.generators.Base);

}).call(this);

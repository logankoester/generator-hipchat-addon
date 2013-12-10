path = require 'path'
yeoman = require 'yeoman-generator'

module.exports = class HipchatAddonGenerator extends yeoman.generators.Base
  constructor: (args, options, config) ->
    yeoman.generators.Base.apply this, arguments
    @on 'end', ->
      unless options['skip-install']
        @spawnCommand 'bundle', ['install']

    @pkg = JSON.parse @readFileAsString path.join __dirname, '../package.json'

  askFor: ->
    cb = @async()

    prompts = [
      type: 'input'
      name: 'appName'
      message: 'Add-on name'
      default: 'MyAddon'
    ,
      type: 'confirm'
      name: 'useRvm'
      message: 'Generate dotfiles for RVM?'
      default: true
    ,
      type: 'list'
      name: 'availability'
      message: 'How will you make this add-on available?'
      choices: [
        { name: 'Available for free', value: 'free' }
        { name: 'Sold through my Stripe account', value: 'stripe' }
      ]
      default: 'stripe'
    ,
      type: 'input'
      name: 'vendorName'
      message: 'Vendor name (your name or organization)'
    ,
      type: 'input'
      name: 'vendorUrl'
      message: 'Vendor URL'
    ,
      type: 'input'
      name: 'appDescription'
      message: 'Brief description'
    ,
      type: 'input'
      name: 'appKey'
      message: 'com.myapp'
    ]

    @prompt prompts, (props) =>
      @useRvm = props.useRvm
      @appName = props.appName
      @availability = props.availability
      @vendorUrl = props.vendorUrl
      @vendorName = props.vendorName
      @appDescription = props.appDescription
      @appKey = props.appKey
      cb()

  app: ->
    @template '_pryrc', '.pryrc'
    @template '_config.ru', 'config.ru'
    @template '_Gemfile', 'Gemfile'

    if @useRvm
      @template '_ruby-gemset', '.ruby-gemset'
      @template '_ruby-version', '.ruby-version'

    @mkdir 'lib'

    @template 'lib/_api.rb', 'lib/api.rb'
    @template 'lib/_app.rb', 'lib/app.rb'
    @template 'lib/_exceptions.rb', 'lib/exceptions.rb'
    @template 'lib/_web.rb', 'lib/web.rb'
    
    @mkdir 'lib/models'
    @template 'lib/models/_account.rb', 'lib/models/account.rb'

    @mkdir 'lib/views'
    @template 'lib/views/_configure.haml', 'lib/views/configure.haml'
    @template 'lib/views/_index.haml', 'lib/views/index.haml'
    @template 'lib/views/_layout.haml', 'lib/views/layout.haml'
    @template 'lib/views/_support.haml', 'lib/views/support.haml'
    @template 'lib/views/_thanks.haml', 'lib/views/thanks.haml'
    if @availability == 'stripe' then @template 'lib/views/_charge.haml', 'lib/views/charge.haml'

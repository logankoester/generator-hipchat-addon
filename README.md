# Hipchat Addon Generator
> A [HipChat Connect Add-On](https://www.hipchat.com/docs/apiv2/addons) is a standalone web application that you write and control, yet it can be installed into a [HipChat](http://hipchat.com) room or account using the built-in [Marketplace](https://marketplace.atlassian.com/) client.

> This [Yeoman](yeoman.io) generator will create a [Sinatra](http://www.sinatrarb.com/) + [Grape](https://github.com/intridea/grape) application
with everything you need to integrate with Hipchat Connect, including optional [Stripe](https://stripe.com/) integration to help you sell your add-ons if you choose.

[![Build Status](https://secure.travis-ci.org/logankoester/generator-hipchat-addon.png?branch=master)](https://travis-ci.org/logankoester/generator-hipchat-addon)
[![status](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/badges/status.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![Dependency Status](https://david-dm.org/logankoester/grunt-rasterize.png)](https://david-dm.org/logankoester/generator-hipchat-addon)
[![devDependency Status](https://david-dm.org/logankoester/grunt-rasterize/dev-status.png)](https://david-dm.org/logankoester/generator-hipchat-addon#info=devDependencies)
[![Gittip](http://img.shields.io/gittip/logankoester.png)](https://www.gittip.com/logankoester/)

[![NPM](https://nodei.co/npm/generator-hipchat-addon.png?downloads=true)](https://nodei.co/npm/generator-hipchat-addon/)

## Getting Started

```
$ npm install -g yo
$ npm install -g generator-hipchat-addon
$ yo hipchat-addon
```

The generator will ask a few questions before creating your app and installing the gem dependencies it needs.
Set the necessary environment variables and then launch it with `rackup`.

## Requirements

* Node
* Ruby 1.9+
* MongoDB
* SSL

You can set up a free environment on [Heroku](https://www.heroku.com/) and [MongoHQ](https://www.mongohq.com/home).

## Running the test suite

    git clone https://github.com/logankoester/generator-hipchat-addon.git
    cd generator-hipchat-addon
    npm install
    grunt test

## Contributing

Fork the repo on Github and open a pull request. Note that the files in `app/` and `test/` are the output of
CoffeeScript files in `src/`, and will be overwritten if edited by hand.

## Release History

#### 0.1.4

  * Resolves an issue wherein haml templates are generated but ERB is called for rendering (thanks [@harrigan](https://github.com/harrigan))

#### 0.1.3

  * Drops support for node v0.8.0 (minimum engine is now v0.10.0)
  * Fix stripe and money dependencies (thanks [@harrigan](https://github.com/harrigan))

#### 0.1.1
  * Initial release.


## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/logankoester/generator-hipchat-addon/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

[![xrefs](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/badges/xrefs.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![funcs](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/badges/funcs.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![top func](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/badges/top-func.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![library users](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/badges/library-users.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![authors](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/badges/authors.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![Total views](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/counters/views.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)
[![Views in the last 24 hours](https://sourcegraph.com/api/repos/github.com/logankoester/generator-hipchat-addon/counters/views-24h.png)](https://sourcegraph.com/github.com/logankoester/generator-hipchat-addon)

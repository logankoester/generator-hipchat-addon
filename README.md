# Hipchat Addon Generator

[![Build Status](https://secure.travis-ci.org/logankoester/generator-hipchat-addon.png?branch=master)](https://travis-ci.org/logankoester/generator-hipchat-addon)

A HipChat Connect Add-On is a standalone web application that you write and control, yet it can be installed into a HipChat room or account using the built-in Marketplace client.

This [Yeoman](yeoman.io) generator will create a [Sinatra](http://www.sinatrarb.com/) + [Grape](https://github.com/intridea/grape) application
with everything you need to integrate with Hipchat Connect, including optional [Stripe](https://stripe.com/) integration to help you sell
your add-ons.

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

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)

require 'open-uri'

require 'grape'
require 'sinatra'
require 'stripe'
require 'rack-flash'
require 'jwt'
require 'mongo_mapper'
require 'money'
require 'oauth2'
require 'haml'

configure do
  MongoMapper.setup({
    ENV['RACK_ENV'] => { 'uri' => ENV['MONGOHQ_URL']}
  }, ENV['RACK_ENV'])
end

module testApp
  class Web < Sinatra::Base
    enable :sessions
    enable :logging

    use ::Rack::Flash

    set :session_secret, ENV['SESSION_SECRET']

    
    set :publishable_key, ENV['STRIPE_PUBLISHABLE_KEY']
    set :secret_key, ENV['STRIPE_SECRET_KEY']

    set :charge_amount, ENV['CHARGE_AMOUNT']
    set :charge_currency, ENV['CHARGE_CURRENCY']
    set :charge_description, ENV['CHARGE_DESCRIPTION']

    ::Stripe.api_key = settings.secret_key
    
  end
end

require './lib/models/account'
require './lib/exceptions'
require './lib/api'
require './lib/web'

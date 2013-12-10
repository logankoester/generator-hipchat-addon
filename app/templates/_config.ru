require './lib/app'

run Rack::Cascade.new [<%= appName %>::API,<%= appName %>::Web]

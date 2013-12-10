require './lib/app'

run Rack::Cascade.new [testApp::API,testApp::Web]

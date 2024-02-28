# require 'rspec'
# require 'rack/test'
# require_relative '../app'

# describe 'GET /' do
#   include Rack::Test::Methods

#   def app
#     Sinatra::Application
#   end

#   it 'returns a 200 status code and "Hello, World!"' do
#     get '/'
#     expect(last_response).to be_ok
#     expect(last_response.body).to include('Hello, World!')
#   end
# end

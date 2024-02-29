# spec/app_spec.rb
require_relative '../app'
require 'rack/test'

describe 'Superscript Coding Test' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should respond with an error if company_number is not valid' do
    post '/', { company_number: 'invalid', contact_name: 'John Doe' }
    expect(last_response.status).to eq(400)
    expect(last_response.body).to include('company_number is not valid')
  end
end

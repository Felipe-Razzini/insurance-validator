# spec/app_spec.rb
require_relative '../app'
require_relative '../helpers'
require 'rack/test'

describe 'ContactNameHelper' do
  include ContactNameHelper

  describe 'normalized_contact_name' do
    it 'returns the correct name' do
      expect(normalized_contact_name('John Doe')).to eq('DOE, John')
    end
    it 'returns the correct name for a name with more than two words' do
      expect(normalized_contact_name('John Jacob Schmidt')).to eq('SCHMIDT, John Jacob')
    end
  end
end

describe 'UserIsDirectorHelper' do
  include UserIsDirectorHelper

  let(:user_data) do
    {
      'items' => [
        {
          'name' => 'DOE, John',
          'officer_role' => 'director'
        },
        {
          'name' => 'SMITH, Jane',
          'officer_role' => 'secretary'
        }
      ]
    }
  end

  it 'returns true if the user is a director' do
    expect(user_is_director?('John Doe', user_data)).to eq(true)
  end
  it 'returns false if the user is not a director' do
    expect(user_is_director?('Jane Smith', user_data)).to eq(false)
  end
end

describe 'Sinatra App' do
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

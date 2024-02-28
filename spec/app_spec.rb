require 'rspec'
require 'webmock/rspec'
require_relative '../app'

describe 'POST /submit' do
  let(:api_key) { ENV['API_KEY'] }
  let(:company_number) { '03684484' }
  let(:contact_name) { 'Eliasz Englander' }

  before do
    # Stub the API requests
    stub_request(:get, "https://api.company-information.service.gov.uk/company/#{company_number}")
      .with(basic_auth: ["#{api_key}", ''])
      .to_return(body: { has_insolvency_history: false }.to_json)

    stub_request(:get, "https://api.company-information.service.gov.uk/company/#{company_number}/officers")
      .with(basic_auth: [api_key, ''])
      .to_return(body: { items: [{ name: 'SMITH, John', officer_role: 'director' }] }.to_json)
  end

  it 'returns a success message if the company has no insolvency history and the user is a director' do
    post '/submit', { company_number: company_number, contact_name: contact_name }
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)['message']).to eq("Great, #{company_name} has no insolvency history and #{contact_name} is a director!")
  end

  # Add more tests for other scenarios
end

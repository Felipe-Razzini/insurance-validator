require 'sinatra'
require 'rest-client'
require 'json'

get '/' do
  send_file 'views/index.html'
end

post '/submit' do
  api_key = 'a3a4b2d7-3556-42db-9583-2289071ba01e'
  company_number = params[:company_number]
  contact_name = params[:contact_name]

  # Make a request to the /company endpoint
  company_response = RestClient::Request.execute(
    method: :get,
    url: "https://api.company-information.service.gov.uk/company/#{company_number}",
    user: api_key,
    password: ''
  )

  company_data = JSON.parse(company_response.body)
  has_insolvency_history = company_data['has_insolvency_history']
  company_name = company_data['company_name']

  # Make a request to the /officers endpoint
  user_response = RestClient::Request.execute(
    method: :get,
    url: "https://api.company-information.service.gov.uk/company/#{company_number}/officers",
    user: api_key,
    password: ''
  )

  user_data = JSON.parse(user_response.body)

  # Normalize the contact name to match the format of the name from the API
  split_name = contact_name.split
  first_name = split_name[0...-1].map(&:capitalize).join(' ')
  last_name = split_name.last.upcase
  normalized_contact_name = "#{last_name}, #{first_name}"

  user_is_director = user_data['items'].any? do |officer|
    officer['name'] == normalized_contact_name && officer['officer_role'] == 'director'
  end

  @message = (
    if !has_insolvency_history && user_is_director
      puts "Great, #{company_name} has no insolvency history and #{contact_name} is a director!"
      'Great, your company qualifies for insurance! Our team will get in touch with you soon!'
    elsif !has_insolvency_history && !user_is_director
      puts "#{company_name} has no insolvency history, but #{contact_name} is NOT a director!"
      'Great, your company qualifies for insurance, but we need to confirm a few details! Our team will get in touch with you soon!'
    elsif has_insolvency_history && user_is_director
      puts "#{company_name} has insolvency history, but #{contact_name} is a director!"
      'Great, your company qualifies for insurance, but we need to confirm a few details! Our team will get in touch with you soon!'
    elsif has_insolvency_history && !user_is_director
      puts "#{company_name} has insolvency history and #{contact_name} is NOT a director!"
      'Sorry, there seems to be an error. Our team will get in touch with you soon!'
    else
      puts 'Oops, something went wrong!'
      'Oops, something went wrong!'
    end
  )

  erb :message
end

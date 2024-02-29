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

  company_data = nil
  # Make a request to the /company endpoint
  begin
    company_response = RestClient::Request.execute(
      method: :get,
      url: "https://api.company-information.service.gov.uk/company/#{company_number}",
      user: api_key,
      password: ''
    )

    company_data = JSON.parse(company_response.body)
  rescue RestClient::NotFound => e
    @message = {
      text: 'No results found for this company number.',
      status: 'warning'
    }
  end

  if company_data
    company_status = company_data['company_status']
    has_insolvency_history = company_data['has_insolvency_history']
    has_been_liquidated = company_data['has_been_liquidated']
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

    puts company_status # string - 0.4
    puts has_been_liquidated # boolean - 0.25
    puts has_insolvency_history # boolean - 0.2
    puts user_is_director # boolean - 0.15

    if %w[Dissolved Removed Closed].include?(company_status)
      @message = {
        text: 'Sorry, there seems to be an error.',
        status: 'warning'
      }
      puts "Superscript should not provide insurance because #{company_name} has too many red flags"
    end

    company_status_score = if %w[Active Registered Open].include?(company_status)
                             1.0 * 0.4 # multiplied by 0.4 to give it a weight of 40%
                           else
                             0.5 * 0.4 # multiplied by 0.4 to give it a weight of 40%
                           end
    has_insolvency_history_score = if has_insolvency_history == false
                                     1.0 * 0.2 # multiplied by 0.2 to give it a weight of 20%
                                   else
                                     0
                                   end
    has_been_liquidated_score = if has_been_liquidated == false
                                  1.0 * 0.25 # multiplied by 0.25 to give it a weight of 25%
                                else
                                  0
                                end
    user_is_director_score = if user_is_director == true
                               1.0 * 0.15 # multiplied by 0.15 to give it a weight of 15%
                             else
                               0
                             end
    company_score = company_status_score + has_insolvency_history_score + has_been_liquidated_score + user_is_director_score

    if (0.7..1.0).cover?(company_score)
      @message = {
        text: 'Great, your company fully qualifies for insurance! Our team will get in touch with you soon!',
        status: 'success'
      }
      puts "Insurance should be provided to #{company_name}! The credit score is #{company_score}!"
    elsif (0.5...0.7).cover?(company_score)
      @message = {
        text: 'Your company qualifies for insurance, but we need to confirm a few details! Our team will get in touch with you soon!',
        status: 'pending'
      }
      puts "Before proviging insurance to #{company_name}, it is advisable to confirm some details. The credit score is #{company_score}!"
    else
      @message = {
        text: 'Sorry, there seems to be an error.',
        status: 'warning'
      }
      puts "Superscript should not provide insurance because #{company_name} has too many red flags"
    end
  else
    @message = {
      text: 'Sorry, please insert a valid company number.',
      status: 'warning'
    }
    puts 'No valid company number.'
  end
  erb :message
end




# if !has_insolvency_history && user_is_director
  #   @message = {
  #     text: 'Great, your company fully qualifies for insurance! Our team will get in touch with you soon!',
  #     status: 'success'
  #   }
  #   puts "Great, #{company_name} has no insolvency history and #{contact_name} is a director!"
  # elsif !has_insolvency_history && !user_is_director
  #   @message = {
  #     text: 'Your company qualifies for insurance, but we need to confirm a few details! Our team will get in touch with you soon!',
  #     status: 'pending'
  #   }
  #   puts "#{company_name} has no insolvency history, but #{contact_name} is NOT a director!"
  # elsif has_insolvency_history && user_is_director
  #   @message = {
  #     text: 'Your company qualifies for insurance, but we need to confirm a few details! Our team will get in touch with you soon!',
  #     status: 'pending'
  #   }
  #   puts "#{company_name} has insolvency history, but #{contact_name} is a director!"
  # elsif has_insolvency_history && !user_is_director
  #   @message = {
  #     text: 'Sorry, there seems to be an error. Our team will get in touch with you soon!',
  #     status: 'warning'
  #   }
  #   puts "#{company_name} has insolvency history and #{contact_name} is NOT a director!"
  # else
  #   @message = {
  #     text: 'Oops, something went wrong!',
  #     status: 'warning'
  #   }
  #   puts 'Oops, something went wrong!'
  # end

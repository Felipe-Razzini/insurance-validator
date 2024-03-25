# Insurance Validator

This is a simple application that allows users to check if their company qualifies for insurance. It uses Ruby, HTML, CSS, Vue JS, and Sinatra for the server.

## Prerequisites

- You will need to have Ruby installed on your machine. You can check if you have Ruby installed, and which version, by running `ruby -v` in your terminal. If you don't have Ruby installed, you can find instructions for installing it on the [official Ruby website](https://www.ruby-lang.org/en/documentation/installation/).
- Bundler: This application uses Bundler to manage Ruby gems. You can check if you have Bundler installed by running `bundler -v` in your terminal. If you don't have Bundler installed, you can install it by running `gem install bundler`.

## Instalation
1. Clone the repository: `git clone git@github.com:Felipe-Razzini/insurance-validator.git`
2. Navigate to the project directory: `cd insurance-validator`
3. Install the required gems: `bundle install`

## API Key

This application uses the Companies House API, which requires an API key. To run this application, you'll need to obtain your own API key:

1. Go to the Companies House website (https://developer.company-information.service.gov.uk/).
2. Register for an account (if you don't have one already).
3. Create a new application (or access an existing application) and generate a new API key.

Once you have your API key, you'll need to add it to the application:

1. Open the `.env` file in the root of the project (create this file if it doesn't exist).
2. Add the following line, replacing `your_api_key` with your actual API key: `API_KEY=your_api_key`

Please note that the `.env` file is included in the `.gitignore` file, so it won't be committed to Git.

## Usage
1. Start the Sinatra server: `ruby app.rb`
2. Open your web browser and navigate to: `http://localhost:4567`
3. On the landing page, click the button labeled "Begin with an assessment now". This will lead you to a form.
4. In the form, type the company registration number and a name. Here are some examples you can use to check different scenarios:
   - Company number: 08499730, Contact full name: Julie Ann Ashmead
   - Company number: 08517657, Contact full name: Patrick James Munns
   - Company number: 08501889, Contact full name: John Smith
5. After submitting the form, a message will be printed in the terminal where the Sinatra server is running, containing a recommendation on whether to provide insurance or not.
6. You will also be redirected to a new page in your web browser, which will display a success or error message based on the result of the risk analysis.
7. If the application is behaving unexpectedly, try stopping the Sinatra server (press `Ctrl+C` in the terminal where the server is running) and starting it again with `ruby app.rb`.

## Running Tests
1. Run the tests: `rspec spec/app_spec.rb`

## License
This project is licensed under the MIT License.

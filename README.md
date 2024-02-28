# Superscript Coding Test - Felipe Razzini

This is a simple application that allows users to check if their company qualifies for insurance. It uses Ruby, HTML, CSS, Vue JS, and Sinatra for the server.

## Prerequisites

- You will need to have Ruby installed on your machine. You can check if you have Ruby installed, and which version, by running `ruby -v` in your terminal. If you don't have Ruby installed, you can find instructions for installing it on the [official Ruby website](https://www.ruby-lang.org/en/documentation/installation/).
- Bundler: This application uses Bundler to manage Ruby gems. You can check if you have Bundler installed by running `bundler -v` in your terminal. If you don't have Bundler installed, you can install it by running `gem install bundler`.

## Instalation
1. Clone the repository: `git clone git@github.com:Felipe-Razzini/superscript-coding-test.git`
2. Navigate to the project directory: `cd superscript-coding-test`
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
3. If you've made changes to the code and they don't seem to be reflected in the application, or if the application is behaving unexpectedly, try stopping the Sinatra server (press `Ctrl+C` in the terminal where the server is running) and starting it again with `ruby app.rb`.

## License
This project is licensed under the MIT License.

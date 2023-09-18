require 'spec_helper'
require 'capybara/rspec'

feature 'External request' do
  it 'Should stub the openweather request.' do
    uri = URI('https://api.openweathermap.org/data/2.5/forecast')

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end
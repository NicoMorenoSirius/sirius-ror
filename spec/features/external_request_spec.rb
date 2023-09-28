require 'rails_helper'

describe 'External request' do
  it 'stubs the openweather request.' do
    uri = URI('https://api.openweathermap.org/data/2.5/forecast?appid='.concat('mockedApiKey'))
    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end

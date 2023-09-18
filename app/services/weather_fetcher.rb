# https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}

class WeatherFetcher < ApplicationService
  attr_reader :zip_code, :appid

  def initialize(api_key, zip_code)
    @appid = api_key
    @zip_code = zip_code
  end

  def call
    fetch_weather
  end

  private

    def fetch_weather
      lat_lon = LatLngCalculator.call(
        appid,
        zip_code
      )
      options = { query: { lat: lat_lon['lat'], lon: lat_lon['lon'], appid: @appid, units: 'metric' } }
      HTTParty.get('https://api.openweathermap.org/data/2.5/forecast', options)
    end
end

# https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}

class WeatherFetcher < ApplicationService

  def initialize(api_key, lat, lon)
    @appid= '2fde67f4550d2c8a2ac06b8d11d3f092'
    @lat = lat
    @lon = lon
  end

  def call
    fetch_weather
  end

  private

  def fetch_weather
    options = { query: {lat: @lat, lon: @lon, appid: @appid, units: 'metric'}}
    HTTParty.get('https://api.openweathermap.org/data/2.5/forecast', options)
  end
end
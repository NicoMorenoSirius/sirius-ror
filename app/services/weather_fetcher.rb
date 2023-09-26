# https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={APIkey}

class WeatherFetcher < ApplicationService
  attr_reader :zip_code, :appid

  def initialize(api_key, zip_code)
    @appid = api_key
    @zip_code = zip_code
  end

  def call
    cached_weather = Rails.cache.read("weather:#{zip_code}")
    if cached_weather.present?
      return WeatherDecorator.new(JSON.parse(cached_weather), true).to_json
    else 
      return WeatherDecorator.new(fetch_weather, false).to_json
    end
  end

  private

  def fetch_weather
    lat_lon = LatLngCalculator.call(
      appid,
      zip_code
    )
    pp lat_lon
    options = { query: { lat: lat_lon['lat'], lon: lat_lon['lon'], appid: @appid, units: 'metric' } }
    weather = HTTParty.get('https://api.openweathermap.org/data/2.5/forecast', options)
    Rails.cache.write("weather:#{zip_code}", weather.to_json, expires_in: 30.minutes)
    return weather
  end
end

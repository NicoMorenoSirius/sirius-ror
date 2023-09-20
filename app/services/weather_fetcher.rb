# https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={APIkey}

class WeatherFetcher < ApplicationService
  attr_reader :zip_code, :appid

  def initialize(api_key, zip_code)
    @appid = api_key
    @zip_code = zip_code
    @redis_server = ActiveSupport::Cache::RedisCacheStore.new(namespace: 'redis', expires_in: 30.minutes)
  end

  def call
    cached_weather = @redis_server.read("weather:#{zip_code}")
    if cached_weather.present? 
      # cant handle this parsed object as a common object so I cant add an attribute
      parsed_weather = JSON.parse(cached_weather)
      return parsed_weather
    else 
      return fetch_weather 
    end
  end

  private

  def fetch_weather
    lat_lon = LatLngCalculator.call(
      appid,
      zip_code
    )
    options = { query: { lat: lat_lon['lat'], lon: lat_lon['lon'], appid: @appid, units: 'metric' } }
    weather = HTTParty.get('https://api.openweathermap.org/data/2.5/forecast', options)
    @redis_server.write("weather:#{zip_code}", weather.to_json)
    return weather
  end
end

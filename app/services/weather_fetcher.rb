# https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={APIkey}

class WeatherFetcher < ApplicationService
  attr_reader :zip_code, :appid

  def initialize(api_key, zip_code)
    @appid = api_key
    @zip_code = zip_code
    @redis_server = ActiveSupport::Cache::RedisCacheStore.new(namespace: 'redis', expires_in: 30.minutes)
  end

  def call
    testest = @redis_server.read("weather:#{zip_code}")
    pp testest
    fetch_weather
  end

  private

  def fetch_weather
    lat_lon = LatLngCalculator.call(
      appid,
      zip_code
    )
    options = { query: { lat: lat_lon['lat'], lon: lat_lon['lon'], appid: @appid, units: 'metric' } }
    weather = HTTParty.get('https://api.openweathermap.org/data/2.5/forecast', options)
    @redis_server.write("weather:#{zip_code}", JSON.generate(weather))
    return weather
  end
end

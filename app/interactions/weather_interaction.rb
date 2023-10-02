class WeatherInteraction < ActiveInteraction::Base
  string :zip_code, presence: true
  string :appid, presence: true

  def execute
    cached_weather = Rails.cache.read("weather:#{zip_code}")
    if cached_weather.present?
      return WeatherDecorator.new(JSON.parse(cached_weather), true).to_json
    else 
      return WeatherDecorator.new(fetch_weather(inputs.slice(:zip_code, :appid)), false).to_json
    end
  end

  private

  def fetch_weather(params)
    outcome = LatLngFromZipCode.run(params)
    weather = HTTParty.get('https://api.openweathermap.org/data/2.5/forecast', options(outcome.result[:lat], outcome.result[:lon]))
    Rails.cache.write("weather:#{zip_code}", weather.to_json, expires_in: 30.minutes)
    return weather
  end

  def options(lat, lon)
    { query: { lat: lat, lon: lon, appid: appid }}
  end
end
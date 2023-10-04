class WeatherInteraction < ActiveInteraction::Base
  string :zip_code, presence: true
  string :appid, presence: true, default: Rails.application.config.open_weather_key

  def execute
    cached_weather = Rails.cache.read("weather:#{zip_code}")

    weather_response = cached_weather || fetch_weather

    WeatherDecorator.new(weather_response, cached_weather.present?).to_json
  end

  private

    def fetch_weather
      outcome = LatLngFromZipCode.run({ zip_code: zip_code })
      weather = HTTParty.get('https://api.openweathermap.org/data/2.5/forecast',
                             options(outcome.result[:lat], outcome.result[:lon]))
      Rails.cache.write("weather:#{zip_code}", weather.to_json, expires_in: 30.minutes)
      weather
    end

    def options(lat, lon)
      { query: { lat:, lon:, appid: } }
    end
end

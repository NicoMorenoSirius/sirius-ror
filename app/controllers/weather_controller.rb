class WeatherController < ApplicationController
  def index
    render json: WeatherFetcher.call(
      Rails.application.config.open_weather_key,
      params[:zip_code]
    )
  end
end

class WeatherController < ApplicationController
  def index
    render json: WeatherFetcher.call(
      Rails.application.config.open_weather_key,
      params[:zip_code]
    )
  end

  def with_interactions
    outcome = WeatherInteraction.run({
                                       zip_code: params[:zip_code],
                                       appid: Rails.application.config.open_weather_key
                                     })
    render json: outcome.valid? ? outcome.result : 'throw error'
  end
end

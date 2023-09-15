class WeatherController < ApplicationController
  
  def index
    latLon = LatLngCalculator.call(
      Rails.application.config.open_weather_key, 
      params[:zip_code]
    )
    render :json => WeatherFetcher.call(
      Rails.application.config.open_weather_key,
      latLon['lat'],
      latLon['lon']
    )
  end
    
end
class WeatherController < ApplicationController
  
  def index
    latLon = LatLngCalculator.call(
      'test', 
      params[:zip_code]
    )
    result = WeatherFetcher.call(
      'test',
      latLon['lat'],
      latLon['lon']
    )
    render :json => result
  end
    
end
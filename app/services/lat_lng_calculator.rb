# http://api.openweathermap.org/geo/1.0/zip?zip={zip code},{country code}&appid={API key}
class LatLngCalculator < ApplicationService

  def initialize(api_key, zip_code)
    @zip_code = zip_code
    @appid= '2fde67f4550d2c8a2ac06b8d11d3f092'
  end

  def call
    fetch_lat_lng_from_zip_code
  end

  private

  def fetch_lat_lng_from_zip_code
    raise ArgumentError, 'Must send zip code' if @zip_code.blank?
    
    zip_param = @zip_code.concat(',us')
    options = { query: {appid: @appid, zip: zip_param} }
    HTTParty.get('http://api.openweathermap.org/geo/1.0/zip', options)
  end
end

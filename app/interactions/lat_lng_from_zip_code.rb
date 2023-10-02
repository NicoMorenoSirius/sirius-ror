class LatLngFromZipCode < ActiveInteraction::Base
  string :zip_code, presence: true, desc: 'US zip code'
  string :appid, presence: true

  def execute
    lat_lng_decorated = LatLngDecorator.new(HTTParty.get('http://api.openweathermap.org/geo/1.0/zip', options))
  end

  private

  def zip_code_country
    "#{zip_code},us"
  end

  def options
    { query: { appid: appid, zip: zip_code_country }}
  end
end
class LatLngDecorator < SimpleDelegator
  def initialize(lat_lng)
    super({ lat: lat_lng['lat'], lon: lat_lng['lon'] })
  end

  def lat
    lat
  end

  def lon
    lon
  end
end

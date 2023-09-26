class WeatherDecorator < SimpleDelegator
  def initialize(weather, from_cache)
    super(weather)
    @from_cache = from_cache
  end

  attr_reader :from_cache

  def location
    city = __getobj__['city']
    "#{city['name']}, #{city['country']}"
  end

  def weather
    WeatherTemperatureDecorator.new(__getobj__['list'][0]['main']).to_json
  end

  def to_json
    {
      location: location,
      weather: weather,
      from_cache: from_cache,
    }
  end

end
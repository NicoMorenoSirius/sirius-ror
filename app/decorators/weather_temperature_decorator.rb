class WeatherTemperatureDecorator < SimpleDelegator
  def pressure
    __getobj__['pressure']
  end

  def humidity
    __getobj__['humidity']
  end

  def temperature
    __getobj__['temp']
  end

  def min_temperature
    __getobj__['temp_min']
  end

  def max_temperature
    __getobj__['temp_max']
  end

  def to_json(*_args)
    {
      pressure:,
      humidity:,
      temperature:,
      min_temperature:,
      max_temperature:
    }
  end
end

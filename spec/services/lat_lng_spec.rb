require 'rails_helper'

class LatLngTest < ActiveSupport::TestCase
  
  test "#Should fail zip code is empty" do
    @lat_lng = LatLngCalculator.call('mockedApiKey', '') 
    assert_raises ArgumentError
  end

  test "#Should get the lat long passing the zipcode" do
    @lat_lng = LatLngCalculator.call('mockedApiKey', '94109') 
    assert_raises ArgumentError
  end
end

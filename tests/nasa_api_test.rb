require_relative 'test_helper'
require './nasa_api'

class NasaApiTest < Minitest::Test
  def setup
    @new_neo = NasaApi.new('2019-03-30')
  end

  def test_api_connect
    assert_equal Faraday::Connection, @new_neo.api_connect.class
  end

  def test_aggregrate_neos_data
    assert_equal Faraday::Response, @new_neo.aggregate_neos_data.class
  end

  def test_parsed_neos_data
    actual = @new_neo.parsed_neos_data[:near_earth_objects][:"2019-03-30"].count
    assert_equal 12, actual
  end

  def test_isolate_date_matches
    assert_equal 12, @new_neo.isolate_date_matches.count
  end

  def test_formatted_neos_data
    assert_equal 12, @new_neo.formatted_neos_data.count
  end
end

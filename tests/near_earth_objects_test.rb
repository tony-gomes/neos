require_relative 'test_helper'
require './lib/near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_neos
    results1 = NearEarthObjects.new('2019-03-30').neos_formatted
    assert_equal 12, results1.count
    assert_equal '(2019 GD4)', results1.first[:name]
    assert_equal '(2019 UZ)', results1.last[:name]

    results2 = NearEarthObjects.new('2020-03-30').neos_formatted
    assert_equal 13, results2.count
    assert_equal '(2020 GO)', results2.first[:name]
    assert_equal '(2020 GD1)', results2.last[:name]
  end
end

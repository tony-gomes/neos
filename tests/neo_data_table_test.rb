require_relative 'test_helper'
require './lib/neo_data_table'

class NeoDataTableTest < Minitest::Test
  def setup
    @new_neo = NeoDataTable.new('2019-03-30')
    @asteroid_details = NearEarthObjects.new('2019-03-30').neos_data_packet
  end

  def test_column_labels
    expected = {
      :name => {
        :label => "Name",
        :width=>17
      },
        :diameter => {
          :label => "Diameter",
          :width=>8
        },
          :miss_distance => {
            :label => "Missed The Earth By:",
            :width => 20
        }
      }

    assert_equal expected, @new_neo.column_data
  end

  def test_column_data
    expected = {
      :name => {
        :label => "Name",
        :width => 17
      },
      :diameter => {
        :label => "Diameter",
        :width => 8
      },
        :miss_distance => {
          :label => "Missed The Earth By:",
          :width => 20
        }
      }

    assert_equal expected, @new_neo.column_data
  end

  def test_create_rows
    asteroid_list = @asteroid_details[:asteroid_list]
    column_data = {
      :name => {
        :label => "Name",
        :width => 17
      },
      :diameter => {
        :label => "Diameter",
        :width => 8
      },
        :miss_distance => {
          :label => "Missed The Earth By:",
          :width => 20
      }
    }

    all_rows = @new_neo.create_rows(asteroid_list, column_data)
    assert_equal all_rows.count, 12
    first_row = {:name=>"(2019 GD4)", :diameter=>"61 ft", :miss_distance=>"911947 miles"}
    assert_equal first_row, all_rows.first

    last_row = {:name=>"(2019 UZ)", :diameter=>"51 ft", :miss_distance=>"37755577 miles"}
    assert_equal last_row, all_rows.last
  end
end

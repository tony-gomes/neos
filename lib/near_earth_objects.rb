require './nasa_api'

class NearEarthObjects
  attr_reader :neos_data_packet

  def initialize(date)
    @date = date
  end

  def neos_formatted
    NasaApi.new(@date).formatted_neos_data
  end

  def parsed_neos_data
    NasaApi.new(@date).isolate_date_matches
  end

  def largest_asteroid_diameter
    parsed_neos_data.map do |asteroid|
      asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  def total_number_of_asteroids
    parsed_neos_data.count
  end

  def neos_data_packet
    {
      query_date: @date,
      asteroid_list: neos_formatted,
      biggest_asteroid: largest_asteroid_diameter,
      total_number_of_asteroids: total_number_of_asteroids
    }
  end
end

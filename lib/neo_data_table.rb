require 'date'
require_relative 'near_earth_objects'

class NeoDataTable
  attr_reader :formatted_date,
              :asteroid_list,
              :total_number_of_asteroids,
              :largest_asteroid

  def initialize(date)
    asteroid_details = NearEarthObjects.new(date).neos_data_packet
    @query_date = asteroid_details[:query_date]
    @asteroid_list = asteroid_details[:asteroid_list]
    @total_number_of_asteroids = asteroid_details[:total_number_of_asteroids]
    @largest_asteroid = asteroid_details[:biggest_asteroid]
    @formatted_date = DateTime.parse(@query_date).strftime("%A %b %d, %Y")
  end

  def column_labels
    {
      name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:"
    }
  end

  def column_data
    column_labels.each_with_object({}) do |(column, label), hash|
      hash[column] = {
        label: label,
        width: [@asteroid_list.map { |asteroid| asteroid[column].size }.max, label.size].max}
    end
  end

  def table_header
    "| #{ column_data.map { |_,column| column[:label].ljust(column[:width]) }.join(' | ') } |"
  end

  def table_divider
    "+-#{column_data.map { |_,column| "-"*column[:width] }.join('-+-') }-+"
  end

  def format_row_data(row_data, column_info)
    row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
    puts "| #{row} |"
  end

  def create_rows(asteroid_data, column_info)
    rows = asteroid_data.each { |asteroid| format_row_data(asteroid, column_info) }
  end
end

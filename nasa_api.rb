require 'faraday'
require 'figaro'

# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NasaApi

  def initialize(date)
    @date = date
  end

  def api_connect
    Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: @date, api_key: ENV['nasa_api_key']}
    )
  end

  def aggregate_neos_data
    api_connect.get('/neo/rest/v1/feed')
  end

  def parsed_neos_data
    JSON.parse(aggregate_neos_data.body, symbolize_names: true)
  end

  def isolate_date_matches
    parsed_neos_data[:near_earth_objects][:"#{@date}"]
  end

  def formatted_neos_data
    isolate_date_matches.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end
end

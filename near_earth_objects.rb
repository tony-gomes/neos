require './neo_compile'

class NearEarthObjects
  attr_reader :neos_formatted

  def initialize(date)
    @neos_formatted = NeoCompile.new(date).neos_data_packet
  end
end

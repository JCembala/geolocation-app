class CreateGeolocation
  def self.call(...)
    new(...).call
  end

  def initialize(network_address:)
    @network_address = network_address
  end

  def call
    Geolocation.find_or_create_by(network_address:) do |geolocation|
      geolocation.response = fetch_geolocation
    end
  end

  private

  attr_reader :network_address

  def fetch_geolocation
    @fetch_geolocation ||=
      IpStack::Api::FetchGeolocation.call(network_address:)
  end
end

class IPLocation

  attr_accessor :city
  attr_accessor :prov_state
  attr_accessor :country
  attr_accessor :isp
  attr_accessor :latitude
  attr_accessor :longitude

  def initialize(georesults)
    parse_ip_location georesults
  end

  protected

  @city = ""
  @prov_state = ""
  @country = ""
  @isp = ""
  @latitude = ""
  @longitude = ""

  def parse_ip_location(response)
      georesults = response.split("|");
      @city= georesults[0]
      @prov_state= georesults[1]
      @country= georesults[2]
      @isp= georesults[3]
      @latitude= georesults[4]
      @longitude= georesults[5]
  end

end
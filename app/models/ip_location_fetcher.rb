require 'net/http'
require 'ip_location'

class IPLocationFetcher
  def initialize
    # we initialize an empty hash
    @cache = {}
  end

  def fetch_location(ip_address, max_age=DEFAULT_MAX_AGE)
    location = fetch_fresh_location(ip_address, max_age)
    if (location.nil?)
      # lookup and store in cache
      location = lookup_location(ip_address)
      if !location.nil?
        add_location(Time.now, ip_address, location)
      end
    end
    return location
  end

  # if the IP address exists as a key in cache, we just return it
  # we also make sure the data is fresh (if specified)
  # if not found or not fresh, return null
  def fetch_fresh_location(ip_address, max_age)
    if @cache.has_key? ip_address
      if Time.now-@cache[ip_address][0] < max_age
        return @cache[ip_address][1]
      end
    end
    return nil
  end

  # add a location to the cache
  def add_location(time, ip_address, location)
    @cache[ip_address] = [time, location]
  end

  protected

  DEFAULT_MAX_AGE = 60 * 60 * 24 * 365 # 1 year, in seconds
  GEOIO_QUERY_PREFIX = "http://api.geoio.com/q.php?key=787mbZ6zp4HZzDhn&qt=geoip&d=pipe&q="

  # look up the location of the IP address via geolocation service
  def lookup_location(ip_address)
    query=GEOIO_QUERY_PREFIX + ip_address
    response = Net::HTTP.get_response(URI.parse(query))
    if response.is_a? Net::HTTPSuccess
      ip_location= IPLocation.new(response.body)
    else
      nil
    end
  end

end
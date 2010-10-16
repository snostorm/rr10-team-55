require 'net/http'
require 'ip_location'

class IPLocationFetcher
  def initialize
    # we initialize an empty hash
    @cache = {}
  end

  def fetch_location(ip_address, max_age=31536000) # 24 * 60 * 60 * 365 = one year in seconds
    location = fetch_fresh_location(ip_address, max_age)
    
    if (location.nil?)
      # lookup and store in cache
      location = lookup_location(ip_address)
      add_location(Time.now, ip_address, location)
      location
    end

  end

  # if the IP address exists as a key in cache, we just return it
  # we also make sure the data is fresh (if specified)
  # if not found or not fresh, return null
  def fetch_fresh_location(ip_address, max_age)
    puts "ip address: " + ip_address
    if @cache.has_key? ip_address
      puts "ip address found: "
      if Time.now-@cache[ip_address][0] < max_age
        puts "Fresh ip address found"
        return @cache[ip_address][1]
      end
    end
    puts "ip address not found"
    nil
  end

  # add a location to the cache
  def add_location(time, ip_address, location)
    @cache[ip_address] = [time, location]
  end

#  protected

#  @@SECONDS_IN_YEAR = 60 * 60 * 24 * 365
  GEOIO_QUERY_PREFIX = "http://api.geoio.com/q.php?key=787mbZ6zp4HZzDhn&qt=geoip&d=pipe&q="

  # look up the location of the IP address via geolocation service
  def lookup_location(ip_address)
    puts "ip address: " + ip_address
    query="http://api.geoio.com/q.php?key=787mbZ6zp4HZzDhn&qt=geoip&d=pipe&q=" + ip_address
    puts "query=" + query
    response = Net::HTTP.get_response(URI.parse(query))
    if response.is_a? Net::HTTPSuccess
      puts "Found"
      ip_location= IPLocation.new(response.body)
    else
      puts "Not Found"
      "Not found"
    end
  end

end
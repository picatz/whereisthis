require 'pry'
require 'socket'
require 'colorize'
require 'ipaddress'
require 'trollop'
require 'unirest'

module Whereisthis
  VERSION = "1.2.0"

  def self.findout!
    # Default to a help menu
    foo = ARGV[0] || ARGV[0] = '-h'

    opts = Trollop::options do
      banner "whereisthis?".bold.red + " Find out where that ip or website is.".bold
      version "#{Whereisthis::VERSION}"
      opt :city,     "Show the city location information if possible"
      opt :region,   "Show the region location information if possible"
      opt :Country,  "Show the country location information if possible"
      opt :gps,      "Show the latitude and longitude information if possible"
      opt :postal,   "Show the postal information if possible"
      opt :org,      "Show the organization information if possible"
      opt :Hostname, "Show the hostname information if possible"
      opt :ip,       "Specify the ip address to lookup",  :type => :string
      opt :website,  "Specify the website url to lookup", :type => :string
    end

    if opts.ip
      unless IPAddress.valid? opts.ip
        puts "Unable to verify '#{opts.ip}' is a valid ip address."
        exit 1
      end
    elsif opts.website
      begin
        opts[:ip] = IPSocket::getaddress(opts.website)
      rescue
        puts "Unable to resolve #{opts.website} to an ip address. Is it legit?"
        exit 1
      end
    elsif ARGV[0]
      if IPAddress.valid? ARGV[0]
        opts[:ip] = ARGV[0]
      else
        begin
          opts[:ip] = IPSocket::getaddress(ARGV[0])
        rescue
          puts "Unable to resolve #{ARGV[0]} to an ip address. Is it legit?"
          exit 1
        end
      end
    end

    unless opts.ip or opts.website
      puts "Need to specify an ip address or website to figure out what it is!"
      exit 1
    end

    Struct.new("WhereIsInfo", :ip, :hostname, :city, :region, :country, :gps, :org, :postal )

    # Get response from web service.
    data = Unirest.get('http://ipinfo.io/' + opts.ip).body
    # Change empty values to false.
    data.each { |k,v| v.empty? ? data[k] = false : data[k] = v  }

    whereisinfo = Struct::WhereIsInfo.new

    # Map data to WhereIsInfo data, defaulting to false for missing info.
    whereisinfo.ip       = data["ip"]       || "Not found."
    whereisinfo.hostname = data["hostname"] || "Not found."
    whereisinfo.city     = data["city"]     || "Not found."
    whereisinfo.region   = data["region"]   || "Not found."
    whereisinfo.country  = data["country"]  || "Not found."
    whereisinfo.gps      = data["loc"]      || "Not found."
    whereisinfo.org      = data["org"]      || "Not found."
    whereisinfo.postal   = data["postal"]   || "Not found."

    # keep track of the filters & delete the given givens
    filter = Hash[opts.keys.keep_if { |k| k.to_s =~ /_given\b/ } .collect { |i| [i, true] } ]
    filter.delete_if { |k,v| k.to_s == "ip_given" }
    filter.delete_if { |k,v| k.to_s == "website_given" }

    # manage output
    if filter.count > 0
      puts "ip: " + whereisinfo.ip             if filter[:ip_given]
      puts "hostname: " + whereisinfo.hostname if filter[:hostname_given]
      puts "city: " + whereisinfo.city         if filter[:city_given]
      puts "region: " + whereisinfo.region     if filter[:region_given]
      puts "country: " + whereisinfo.country   if filter[:Country_given]
      puts "gps: " + whereisinfo.gps           if filter[:gps_given]
      puts "org: " + whereisinfo.org           if filter[:org_given]
      puts "postal: " + whereisinfo.postal     if filter[:postal_given]
    else
      # fancy spaces
      puts "      ip: " + whereisinfo.ip
      puts "hostname: " + whereisinfo.hostname
      puts "    city: " + whereisinfo.city
      puts "  region: " + whereisinfo.region
      puts " country: " + whereisinfo.country
      puts "     gps: " + whereisinfo.gps
      puts "     org: " + whereisinfo.org
      puts "  postal: " + whereisinfo.postal
    end

  end

end

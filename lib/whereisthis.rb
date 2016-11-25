#!/usr/bin/env ruby
#
# Whereisthis
#
# This is a simple command-line application to help determine
# the location information from a given ip address or url.
#
# Author::    Kent 'picat' Gruber
# Copyright:: Copyright (c) 2016 Kent Gruber
# License::   MIT

require 'socket'
require 'colorize'
require 'ipaddress'
require 'trollop'
require 'unirest'

module Whereisthis

  # Specify version number.
  VERSION = "1.3.0"

  # .findout! is the main workhorse of this application. It starts
  # the option parsing; and performs the main logic for basically
  # everything.
  #
  # == Example
  #
  #  # Typical use:
  #  require 'whereisthis'
  #  ARGV[0] = "8.8.8.8"
  #  Whereisthis.findout!
  #
  def self.findout!
    # Default to a help menu if no argument is given.
    foo = ARGV[0] || ARGV[0] = '-h'

    # Parse options into a hash.
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

    # If an ip is specified with -i or --ip at the command-line.
    if opts.ip
      unless IPAddress.valid? opts.ip
        raise "Unable to verify '#{opts.ip}' is a valid ip address."
      end
    # If an website is specified with -w or --website at the command-line.
    elsif opts.website
      begin
        opts[:ip] = IPSocket::getaddress(opts.website)
      rescue
        raise "Unable to resolve #{opts.website} to an ip address. Is it legit?"
      end
    # If the first argument is simply an IP address or website.
    elsif ARGV[0]
      if IPAddress.valid? ARGV[0]
        opts[:ip] = ARGV[0]
      else
        begin
          opts[:ip] = IPSocket::getaddress(ARGV[0])
        rescue
          raise "Unable to resolve #{ARGV[0]} to an ip address. Is it legit?"
        end
      end
    end

    # A container of data for our information.
    Struct.new("WhereIsInfo", :ip, :hostname, :city, :region, :country, :gps, :org, :postal )

    # Get response from web service.
    data = Unirest.get('http://ipinfo.io/' + opts.ip).body
    # Change empty values to false.
    data.each { |k,v| v.nil? || v.empty? ? data[k] = false : data[k] = v  }

    whereisinfo = Struct::WhereIsInfo.new
    missing_info = "Not found."

    # Map data to WhereIsInfo data, defaulting to false for missing info.
    whereisinfo.ip       = data["ip"]       || missing_info
    whereisinfo.hostname = data["hostname"] || missing_info
    whereisinfo.city     = data["city"]     || missing_info
    whereisinfo.region   = data["region"]   || missing_info
    whereisinfo.country  = data["country"]  || missing_info
    whereisinfo.gps      = data["loc"]      || missing_info
    whereisinfo.org      = data["org"]      || missing_info
    whereisinfo.postal   = data["postal"]   || missing_info

    # Keep track of the filters & delete the given givens,
    # because we don't need to keep track of them.
    filter = Hash[opts.keys.keep_if { |k| k.to_s =~ /_given\b/ } .collect { |i| [i, true] } ]
    filter.delete_if { |k,v| k.to_s == "ip_given" }
    filter.delete_if { |k,v| k.to_s == "website_given" }

    # Manage output with or without filters/ fancy spaces.
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

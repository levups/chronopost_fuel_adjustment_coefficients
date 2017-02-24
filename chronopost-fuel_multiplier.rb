# frozen_string_literal: true
require "addressable/uri"
require "httparty"
require "nokogiri"

# The HTTParty documentation advise to create new classes to parameter behavior
class PlainHttpClient
  include HTTParty

  uri_adapter Addressable::URI
end

class ChronopostFuelMultiplier
  attr_reader :url

  def initialize(url = 'http://www.chronopost.fr/fr/surcharge-carburant')
    @url  = url 
    @page = Nokogiri::HTML get(@url).body
  end

  def time_period
    @time_period ||= @page.at_css("table.ch-table thead tr th:last-child").text
  end

  def air_multiplier
    @air_multiplier ||= "%.4f" % (@page.at_css("table.ch-table tbody tr:last-child td:last-child").text.to_f / 100 + 1)
  end

  def road_multiplier
    @road_multiplier ||= "%.4f" % (@page.at_css("table.ch-table tbody tr td:last-child").text.to_f / 100 + 1)
  end

private

  # Simple HTTP request made with HTTParty gem to get raw HTML from remote server.
  def get(url)
    PlainHttpClient.get(url, httparty_options)
  end

  def httparty_options
    {
      limit:   3,
      timeout: 10
    }
  end
end

ch = ChronopostFuelMultiplier.new
puts "# Fuel multipliers for #{ch.time_period}"
puts "# #{ch.url}"
puts "AIR_FUEL_MULTIPLIER  = #{ch.air_multiplier}"
puts "ROAD_FUEL_MULTIPLIER = #{ch.road_multiplier}"

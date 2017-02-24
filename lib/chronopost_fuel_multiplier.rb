# frozen_string_literal: true
require "addressable/uri"
require "httparty"
require "nokogiri"
require "plain_http_client"

class ChronopostFuelMultiplier
  URL = 'http://www.chronopost.fr/fr/surcharge-carburant'

  def initialize
    response = PlainHttpClient.get(url, limit: 3, timeout: 10)
    @page = Nokogiri::HTML response.body
  end

  def time_period
    @page.at_css("table.ch-table thead tr th:last-child").text
  end

  def air_multiplier
    "%.4f" % (@page.at_css("table.ch-table tbody tr:last-child td:last-child").text.to_f / 100 + 1)
  end

  def road_multiplier
    "%.4f" % (@page.at_css("table.ch-table tbody tr td:last-child").text.to_f / 100 + 1)
  end

  def url
    URL
  end
end

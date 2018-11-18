# frozen_string_literal: true

require 'bigdecimal'
require 'http'

class ChronopostFuelAdjustmentCoefficients
  attr_reader :time_period

  def initialize
    @time_period, @routier, @aerien = extracted_content
  end

  def air_multiplier
    format_multiplier @aerien
  end

  def road_multiplier
    format_multiplier @routier
  end

  def url
    'https://www.chronopost.fr/fr/surcharge-carburant'
  end

  private

  def response
    ::HTTP.timeout(10).get(url)
  rescue HTTP::Error
    ''
  end

  def extracted_content
    html = response.to_s.delete("\n").gsub(/\s+/, " ")

    return [] unless tables = html.split("<table ")[1]
    return [] unless table  = tables.split("<h2>Principe</h2>").first
    return [] unless head   = table.scan(%r{<thead>.*</thead>}).first
    return [] unless period = head.match(%r{<p>(?<content>.*)</p>})
    return [] unless body   = table.scan(%r{<tbody><tr>.*</tr></tbody>}).first

    time_period  = period[:content].sub("<br />", "")
    adjustements = body.split("</tr><tr>").map do |line|
      line.to_s.rpartition("</td>").first.rpartition(">").last
    end

    [time_period, adjustements[0], adjustements[1]]
  end

  def format_multiplier(string)
    return unless string

    number = (string.to_f / 100 + 1).round(4)
    BigDecimal(number.to_s)
  end
end

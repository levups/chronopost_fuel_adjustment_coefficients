# frozen_string_literal: true

require 'bigdecimal'
require 'http'
require 'oga'

class ChronopostFuelAdjustmentCoefficients
  def initialize
    @document = ::Oga.parse_html response.to_s
  end

  def time_period
    el = @document.at_css('table.ch-table thead tr th:last-child')
    return unless el

    el.text.strip.gsub(/\s+/, ' ')
  end

  def air_multiplier
    el = @document.at_css('table.ch-table tbody tr:last-child td:last-child')
    return unless el

    format_multiplier el.text
  end

  def road_multiplier
    el = @document.at_css('table.ch-table tbody tr td:last-child')
    return unless el

    format_multiplier el.text
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

  def format_multiplier(string)
    number = (string.to_f / 100 + 1).round(4)
    BigDecimal(number.to_s)
  end
end

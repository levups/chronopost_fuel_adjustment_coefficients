# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/stub_any_instance'
require 'chronopost_fuel_adjustment_coefficients'

class ChronopostFuelAdjustmentCoefficientsTest < Minitest::Test
  def test_time_period
    nominal_case do
      assert_equal 'Novembre 2018', @adjustement_coefficient.time_period
    end

    failing_case do
      assert_nil @adjustement_coefficient.time_period
    end
  end

  def test_air_multiplier
    nominal_case do
      assert_equal 1.2000, @adjustement_coefficient.air_multiplier
    end

    failing_case do
      assert_nil @adjustement_coefficient.air_multiplier
    end
  end

  def test_road_multiplier
    nominal_case do
      assert_equal 1.1400, @adjustement_coefficient.road_multiplier
    end

    failing_case do
      assert_nil @adjustement_coefficient.road_multiplier
    end
  end

  FRENCH_MONTHS = %w[janvier février mars avril mai juin juillet août
                     septembre octobre novembre décembre].freeze

  def test_live_values
    live_chronopost = ChronopostFuelAdjustmentCoefficients.new

    time_period   = live_chronopost.time_period
    current_month = FRENCH_MONTHS[Date.today.month - 1]

    assert_kind_of String, time_period
    assert time_period.downcase.start_with?(current_month)
    assert time_period.end_with?(Date.today.year.to_s)

    assert_kind_of BigDecimal, live_chronopost.air_multiplier
    assert_operator live_chronopost.air_multiplier, :>=, 1.0

    assert_kind_of BigDecimal, live_chronopost.road_multiplier
    assert_operator live_chronopost.road_multiplier, :>=, 1.0
  end

  private

  def nominal_case
    res = File.read('test/sample_response.html')
    ChronopostFuelAdjustmentCoefficients.stub_any_instance :response, res do
      @adjustement_coefficient = ChronopostFuelAdjustmentCoefficients.new
      yield
    end
  end

  def failing_case
    ChronopostFuelAdjustmentCoefficients.stub_any_instance :response, '' do
      @adjustement_coefficient = ChronopostFuelAdjustmentCoefficients.new
      yield
    end
  end
end

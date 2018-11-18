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

  def test_live_values
    skip if stub_tests?

    live_chronopost = ChronopostFuelAdjustmentCoefficients.new
    colissimo_date = Date.parse live_chronopost.time_period

    assert_equal Date.today.month, colissimo_date.month
    assert_equal Date.today.year, colissimo_date.year

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

  def stub_tests?
    !(ENV["NO_STUBBED_TESTS"] || ENV["TRAVIS_EVENT_TYPE"] == "cron")
  end
end

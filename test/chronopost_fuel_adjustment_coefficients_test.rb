# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/stub_any_instance'
require 'chronopost_fuel_adjustment_coefficients'

class ChronopostFuelAdjustmentCoefficientsTest < Minitest::Test
  def test_time_period
    nominal_case do
      assert_equal 'Novembre 2018', @adjustement_coefficient.time_period
    end

    failing_response do
      assert_nil @adjustement_coefficient.time_period
    end
  end

  def test_air_multiplier
    nominal_case do
      assert_equal 1.2000, @adjustement_coefficient.air_multiplier
    end

    failing_response do
      assert_nil @adjustement_coefficient.air_multiplier
    end
  end

  def test_road_multiplier
    nominal_case do
      assert_equal 1.1400, @adjustement_coefficient.road_multiplier
    end

    failing_response do
      assert_nil @adjustement_coefficient.road_multiplier
    end
  end

  private

  def nominal_case
    res = File.read('test/sample_response.html')
    ChronopostFuelAdjustmentCoefficients.stub_any_instance :response, res do
      @adjustement_coefficient = ChronopostFuelAdjustmentCoefficients.new
      yield
    end
  end

  def failing_response
    ChronopostFuelAdjustmentCoefficients.stub_any_instance :response, '' do
      @adjustement_coefficient = ChronopostFuelAdjustmentCoefficients.new
      yield
    end
  end
end

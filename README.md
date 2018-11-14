# Chronopost Fuel Multipliers fetcher

Retrieve current air and road rates applied to Chronopost shipping costs and
convert them to multipliers we can directly use in our shipping cost
calculators.

## Usage

Install the gem:

    $ gem install chronopost_fuel_adjustment_coefficients

Run the gem:

    $ chronopost_fuel_adjustment_coefficients

Get the result:

    # Fuel multipliers for 'Février 2017'
    # Fetched from http://www.chronopost.fr/fr/surcharge-carburant

    AIR_FUEL_MULTIPLIER  = 1.1685
    ROAD_FUEL_MULTIPLIER = 1.1150

Or use it in your app:

    require 'chronopost_fuel_adjustment_coefficients'

    ch = ChronopostFuelAdjustmentCoefficients.new
    ch.road_multiplier      # 0.11685e1
    ch.air_multiplier       # 0.1115e1

Gem::Specification.new do |s|
  s.name        = 'chronopost_fuel_multiplier'
  s.version     = '0.1.2'
  s.date        = '2017-06-12'
  s.summary     = 'Retrieve current month\'s Chronopost\'s fuel surcharges'
  s.description = 'A simple gem to ease/automate getting this data every month.'
  s.authors     = ['Bob Maerten', 'Clément Joubert']
  s.files       = Dir['lib/*.rb'] + Dir['bin/*']
  s.email       = ['bob@levups.com', 'clement@levups.com']
  s.homepage    = 'https://rubygems.org/gems/chronopost_fuel_multiplier'
  s.license     = 'MIT'

  s.bindir      = 'bin'
  s.executables = 'chronopost_fuel_multiplier'

  s.add_runtime_dependency 'addressable', '~> 2.5'
  s.add_runtime_dependency 'httparty',    '~> 0.16'
  s.add_runtime_dependency 'nokogiri',    '~> 1.8'
end

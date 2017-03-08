Gem::Specification.new do |s|
  s.name        = 'chronopost_fuel_multiplier'
  s.version     = '0.1.1'
  s.date        = '2017-03-08'
  s.summary     = 'Retrieve current month\'s Chronopost\'s fuel surcharges'
  s.description = 'A simple gem to ease/automate getting this data every month.'
  s.authors     = ['Bob Maerten', 'Clément Joubert']
  s.files       = Dir['lib/*.rb'] + Dir['bin/*']
  s.email       = ['bob.maerten@gmail.com', 'clement.joubert@gmail.com']
  s.homepage    = 'https://rubygems.org/gems/chronopost_fuel_multiplier'
  s.license     = 'MIT'

  s.bindir      = 'bin'
  s.executables = 'chronopost_fuel_multiplier'

  s.add_runtime_dependency 'addressable', '~> 2.5.0'
  s.add_runtime_dependency 'httparty',    '~> 0.14.0'
  s.add_runtime_dependency 'nokogiri',    '~> 1.7.0.1'
end

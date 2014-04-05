require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'twitter'
require 'json'
require 'net/http'
require './weather_anchor.rb'
require './beaufort_scale.rb'
require './tweeter.rb'


task :weather do
  WeatherAnchor.update!
end

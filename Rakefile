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

task :say, :arg1 do |t, arg|
  Tweeter.tweet_it! arg[:arg1]
end

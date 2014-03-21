# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'twitter'
require 'json'
require 'net/http'

def convert(farenheit)
  ((farenheit - 32) * 5/9).round(0)
end

task :update do
  uri = URI("https://api.forecast.io/forecast/be48af43dc14167188e50f22a55db05f/42.0000,21.4333")
  json = JSON.parse(Net::HTTP.get(uri))
  temperature = convert(json['currently']["temperature"])
  puts json['currently']

  tweet_content = case temperature
                  when -100..-20
                    "#{temperature} степени. Ладно нек си ибе мајката!"
                  when -19..-10
                    "#{temperature} степени, грч ладно."
                  when -9..0
                    "Многу ладно. #{temperature} степени."
                  when 1..10
                    "Свежичко, #{temperature} степени"
                  when 11..20
                    "Пријатно. #{temperature} степени"
                  when 21..25
                    "#{temperature} степени, oдлично e!"
                  when 26..35
                    "Топлоooo. (#{temperature} степени)"
                  when 36..42
                    "Мнооогу топло! Фаќа накај 40ка..."
                  when 42..100
                    "ПЕКОЛ!"
                  end

  twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "0r0kNvoecSKgdrlDXHYw"
    config.consumer_secret     = "DBtCxX9Lf9gRYaCU4hdcZChufAqtwiaPVrbQZUdbU"
    config.access_token        = "2400637903-YbCFWKtfUbo3ta7EBinwVnNEEIWaaskQoGTJy4h"
    config.access_token_secret = "KShlsu4UYGQQP83en0aAXpB7zNq09NulGIfQ4a9RdrBVf"
  end

  twitter_client.update(tweet_content)
end

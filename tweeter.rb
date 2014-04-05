class Tweeter

  class << self
    def tweet_it!(tweet)
      new(tweet).tweet_it!
    end
  end

  def initialize(tweet)
    @tweet = tweet
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def tweet_it!
    puts "Tweeted: #{@tweet}"
    @twitter_client.update(@tweet)
  end

end

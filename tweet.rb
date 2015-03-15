require "rubygems"
require "tweetstream"
require "screencap"
require 'open-uri'
require 'dotenv'
Dotenv.load

TweetStream.configure do |config|
  config.consumer_key       = 'rDG67HyayMJvZiHCOcmCG2OF2'
  config.consumer_secret    = '9eU72lyxRe2SfB0tyvTC4s2ipV3DHwjHoYnsaLPgzl64HA0K0E'
  config.oauth_token        = '465969666-hk4KzQ7wsQRSiINeQzfWQ1429GEuSKIUHwnSFKa4'
  config.oauth_token_secret = 'w8AEprj50hUib82YxWwFWSgDpL3bONtcj7imHNwizguGb'
  config.auth_method        = :oauth
end

# This will pull a sample of all tweets based on
# your Twitter account's Streaming API role.
TweetStream::Client.new.track('#hacktheburgh') do |status|
    puts "hello"
    puts status.inspect
    puts status.user.name
  if status.media?
    puts "yes"
    puts status.media[0].media_url
    f = Screencap::Fetcher.new("http://localhost:5000/print_tweet?user=#{status.user.name}&image=#{status.media[0].media_url}&tweet=#{URI::encode(status.text)}")
    screenshot = f.fetch(
        :output => 'tweet.png', # don't forget the extension!
        :width => 400
    )
    system("lpr", "tweet.png")
  else
    f = Screencap::Fetcher.new("http://localhost:5000/print_tweet?user=#{status.user.name}&tweet=#{URI::encode(status.text)}")
    screenshot = f.fetch(
        :output => 'tweet.png', # don't forget the extension!
        :width => 400
    )
    system("lpr", "tweet.png")
  end
end

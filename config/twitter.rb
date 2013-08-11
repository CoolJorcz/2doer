Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
end

use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end

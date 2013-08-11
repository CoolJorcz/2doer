ENV['TWITTER_KEY'] ="TIb8pVtCWRzhUsAWD6g"
ENV['TWITTER_SECRET'] = "rXbssiCjbRywiXm7ywKvaT7d9DjNfDyn9Bkt5zbJw"

Twitter.configure do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
end


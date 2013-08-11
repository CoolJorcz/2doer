get '/fetch' do
  lastest_tweet = Task.where(:doer_id => current_user.id).order("tweet_id DESC").limit(1)
  if lastest_tweet.any?
    latest_tweet = latest_tweet.first.tweet_id.to_i
  else
    latest_tweet = 0
  end
  twitters = Twitter.search("to:#{current_user.handle} #2doer", :since_id => latest_tweet).statuses
  "#{twitters.map { |t| "tweet: #{t[:text]}, since: #{t[:id]}, asker: #{t[:user][:screen_name]}, doer: #{current_user.id}"}}"
end

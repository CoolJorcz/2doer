get '/fetch' do
  latest_tweet = Task.where(:doer_id => current_user.id).order("tweet_id DESC").limit(1)
  if latest_tweet.any?
    latest_tweet = latest_tweet.first.tweet_id.to_i
  else
    latest_tweet = 0
  end
  twitters = Twitter.search("to:#{current_user.handle} #2doer", :since_id => latest_tweet).statuses
  twitters.reverse.map do |tweet|
    body = tweet[:text].gsub(/[@#][^\s]*\s?/, '')
    task = Task.create(:body => body,
                :status => "pending",
                :tweet_id => tweet[:id].to_s,
                :asker => User.where(:handle => tweet[:user][:screen_name]).first_or_create,
                :doer => current_user)
    task.status = "pending"
    task.save
    {:body => body, :id => task.id}
  end.to_json
end

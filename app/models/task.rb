class Task < ActiveRecord::Base
  belongs_to :doer, :class_name => "User"
  belongs_to :asker, :class_name => "User"

  scope :incoming, -> { where(bluejay: "pending")}
  scope :accepted, -> { where(bluejay: "accepted")}
  scope :completed, -> { where(bluejay: "completed")}
  scope :rejected, -> { where(bluejay: "rejected")}

  def accept_tweet(body, current_user)
    self.bluejay = "accepted"
    self.save
    user = current_user

    client = Twitter::Client.new(:consumer_key => ENV['TWITTER_KEY'],
                                  :consumer_secret => ENV['TWITTER_SECRET'],
                                  :oauth_token => user.token,
                                  :oauth_token_secret => user.secret)

     client.update(body + self.tweet_id)
  end

  def decline_tweet(body, current_user)
    self.bluejay = "rejected"
    self.save
    user = current_user

    client = Twitter::Client.new(:consumer_key => ENV['TWITTER_KEY'],
                                  :consumer_secret => ENV['TWITTER_SECRET'],
                                  :oauth_token => user.token,
                                  :oauth_token_secret => user.secret)

     client.update(body + self.tweet_id)
  end
end

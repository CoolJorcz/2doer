class Task < ActiveRecord::Base
  attr_writer :status
  belongs_to :doer, :class_name => "User"
  belongs_to :asker, :class_name => "User"

  scope :incoming, -> { where(status: "incoming")}
  scope :accepted, -> { where(status: "accepted")}
  scope :completed, -> { where(status: "completed")}
  scope :rejected, -> { where(status: "rejected")}

  def accept_tweet(body, current_user)
    self.status = "accepted"
    self.save
    user = current_user

    client = Twitter::Client.new(:consumer_key => ENV['TWITTER_KEY'],
                                  :consumer_secret => ENV['TWITTER_SECRET'],
                                  :oauth_token => user.token,
                                  :oauth_token_secret => user.secret)

     client.update(body + " " + "#2doer")
  end

  def decline_tweet(body, current_user)
    self.status = "rejected"
    self.save
    user = current_user

    client = Twitter::Client.new(:consumer_key => ENV['TWITTER_KEY'],
                                  :consumer_secret => ENV['TWITTER_SECRET'],
                                  :oauth_token => user.token,
                                  :oauth_token_secret => user.secret)

     client.update(body + " " + "#2doer")
  end
end

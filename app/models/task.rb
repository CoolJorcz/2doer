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

    client = Twitter::Client.new(
      :oauth_token => user.token,
      :oauth_token_secret => user.secret)

     client.update("@" + self.asker.handle + " " + body + " 2doer.us/tw/" + self.id.to_s, { "in_reply_to_status_id" => self.tweet_id } )
  end

  def decline_tweet(body, current_user)
    self.bluejay = "rejected"
    self.save
    user = current_user

    client = Twitter::Client.new(
      :oauth_token => user.token,
      :oauth_token_secret => user.secret)

     client.update("@" + self.asker.handle + " " + body + " 2doer.us/tw/" + self.id.to_s, { "in_reply_to_status_id" => self.tweet_id } )
  end

  def complete_tweet(curren_user)
    self.bluejay = "completed"
    self.save

    client = Twitter::Client.new(
      :oauth_token => curren_user.token,
      :oauth_token_secret => curren_user.secret)

    client.update("@" + self.asker.handle + " All done! 2doer.us/tw/" + self.id.to_s, { "in_reply_to_status_id" => self.tweet_id } )
  end
end

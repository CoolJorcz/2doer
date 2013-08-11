class User < ActiveRecord::Base
  has_many :obligations, :class_name => "Task", foreign_key: :doer_id
  has_many :requests, :class_name => "Task", foreign_key: :asker_id

  def self.login(res)
    @user         = User.where(:uid => res["uid"]).first_or_initialize
    @user.handle  = res['info']['nickname']
    @user.name    = res['info']['name']
    @user.token   = res['credentials']['token']
    @user.secret  = res['credentials']['secret']
    @user.save
    @user
  end

  def incoming
    Task.incoming.where(:doer_id => self.id)
  end

  def accepted
    Task.accepted.where(:doer_id => self.id)
  end

  def rejected
    Task.rejected.where(:doer_id => self.id)
  end

  def completed
    Task.completed.where(:doer_id => self.id)
  end

  def tweet_task(params)

     # doer = User.find_by_handle(strip_handle(params[:doer]))
     # p "Here is the doer!!!!!!!!!!!!!!!!!!!!"
     # p doer
     # p strip_handle(params[:doer])
     # task = Task.new(:asker_id => self.id, 
     #                 :doer_id => doer.id,
     #                 :body => params[:body],
     #                 :status => "incoming")
     # task.save
     client = Twitter::Client.new(:consumer_key => ENV['TWITTER_KEY'],
                                  :consumer_secret => ENV['TWITTER_SECRET'],
                                  :oauth_token => self.token,
                                  :oauth_token_secret => self.secret)

     client.update(params[:handle] + " " + params[:body] + " " + "#2doer")
     # client.update("@" + task.doer.handle + " " + task.body + " #2doer")
  end

  def tweet_invite(params)
    client = Twitter::Client.new(oauth_token: self.token,
                                 oauth_token_secret: self.secret)
    client.update(params[:invitee] + " " + params[:invite] + " #2doer")
  end
end

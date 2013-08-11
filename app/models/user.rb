class User < ActiveRecord::Base
  has_many :obligations, :class_name => "Task"
  has_many :requests, :class_name => "Task"

  def self.login(res)
    @user         = User.where(:uid => res["uid"]).first_or_initialize
    @user.handle  = res['info']['nickname']
    @user.name    = res['info']['name']
    @user.token   = res['credentials']['token']
    @user.secret  = res['credentials']['secret']
    @user.save
    @user
  end

  def tweet_task(params)
     doer = User.where(:handle => params[:doer])
     task = Task.new(:asker_id => self.id, :doer_id => doer.id,:body => params[:body])
     task.save
     client = Twitter::Client.new(oauth_token: self.token,
                                 oauth_token_secret: self.secret)

     client.update(t.doer + " " + task.body + " #2doer")
  end

  def tweet_invite(params)
    client = Twitter::Client.new(oauth_token: self.token,
                                 oauth_token_secret: self.secret)
    client.update(params[:invitee] + " " + params[:invite] + " #2doer")
  end
end

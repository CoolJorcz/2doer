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
  # def create_client
  #   Twitter::Client.new(
  #       :oauth_token => self.oauth_token,
  #       :oauth_token_secret => self.oauth_secret
  #     )
  # end
end

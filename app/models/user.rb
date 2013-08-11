class User < ActiveRecord::Base
  has_many :obligations, :class_name => "Task"
  has_many :requests, :class_name => "Task"


  # def create_client
  #   Twitter::Client.new(
  #       :oauth_token => self.oauth_token,
  #       :oauth_token_secret => self.oauth_secret
  #     )
  # end
end

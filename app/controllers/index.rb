get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/tweet' do
  # text = params[:text]
  # @current_user = current_user
  
  # client = Twitter::Client.new(oauth_token: @current_user.oauth_token, 
  #                              oauth_token_secret: @current_user.oauth_secret)
  # #is it possible to call methods on the helper method which generates a current user
  # @current_tweet = client.update(text)

  # if request.xhr?
  #   erb :_tweet_content, layout: false
  # else
  #   erb :index
  # end
end

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do
  p ENV['TWITTER_KEY']
  p ENV['TWITTER_SECRET']
  redirect request_token.authorize_url
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  
  @user = User.find_or_create_by_username(:username => @access_token.params[:screen_name])

  @user.update_attributes(:oauth_token => @access_token.token, :oauth_secret => @access_token.secret)

  session[:user_id] = @user.id
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  redirect to('/')
  # at this point in the code is where you'll need to create your user account and store the access token
end

post '/tweet' do
  text = params[:text]
  @current_user = current_user
  
  client = Twitter::Client.new(oauth_token: @current_user.oauth_token, 
                               oauth_token_secret: @current_user.oauth_secret)
  #is it possible to call methods on the helper method which generates a current user
  @current_tweet = client.update(text)

  if request.xhr?
    erb :_tweet_content, layout: false
  else
    erb :index
  end
end

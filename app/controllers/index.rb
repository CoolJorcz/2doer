get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/auth/twitter/callback' do
  @user = User.login(request.env['omniauth.auth'])
  session[:id] = @user.id
  redirect "/dashboard/#{@user.handle}"
end

get '/dashboard/:handle' do
  @user = User.find(session[:id])
  erb :dashboard
end

post '/tasks/new' do
  # if  User.where(:handle =>  strip_handle(params[:doer])).any?
    @user = User.find(session[:id])
    @user.tweet_task(params)
    redirect "/dashboard/#{@user.handle}"
  # else 
  #   p params
  #   redirect "/invite"
  # end
end

# get '/invite' do 
#   @user = User.find(session[:id])
#   erb :invite
# end

# post '/invite' do
#   @user = User.find(session[:id])
#   @user.tweet_invite(params)
#   redirect '/dashboard'
# end

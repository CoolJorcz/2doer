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
  erb :dashboard
end

post '/tasks/new' do
  if  User.any?(:handle => params[:doer])
    @user = User.find(session[:id])
    @user.tweet_task(params)
    redirect "/dashboard/#{@user.handle}"
  else 
    redirect "/invite"
  end
end

get '/invite' do 
  @user = User.find(session[:id])
  erb :invite
end

post '/invite' do
  @user = User.find(session[:id])
  @user.tweet_invite(params)
  redirect '/dashboard'
end

post '/tweet' do

end


get '/dashboard' do
  erb :dashboard
end

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


post '/tweet' do

end


get '/dashboard' do
  erb :dashboard
end

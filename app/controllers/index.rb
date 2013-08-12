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

get '/tasks/:id/accept' do
  @task = Task.find(params[:id])
  erb :_confirm
end

get '/tasks/:id/reject' do
  @task = Task.find(params[:id])
  erb :_confirm
end

post '/tasks/:id/accept' do
  @task = Task.find(params[:id])
  @user = User.find(session[:id])
  @task.accept_tweet(params[:body], @user)
  redirect "/dashboard/#{@user.handle}"
end

post '/tasks/:id/decline' do
  @task = Task.find(params[:id])
  @user = User.find(session[:id])
  @task.decline_tweet(params[:body], @user)
  redirect "/dashboard/#{@user.handle}"
end

get '/tw/:id' do
  @task = Task.find(params[:id])
  redirect "http://twitter.com/#{@task.asker.handle}/status/#{@task.tweet_id}"
end

get '/tasks/:id/complete' do
  @task = Task.find(params[:id])
  @task.complete_tweet(current_user)

  @task.update(:bluejay => "completed")
  redirect "/dashboard/#{@task.doer.handle}"
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

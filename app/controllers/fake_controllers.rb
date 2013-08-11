get '/dashboard' do
  erb :dashboard
end

get '/accept-task' do
  erb :accept_task
end

get '/confirm' do
  erb :_confirm_
end

get '/request' do
  erb :_request_
end

get '/decline' do
  erb :_decline_
end

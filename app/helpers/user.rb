def current_user
  @_current_user ||= User.find_by_id(session[:id])
end

def logged_in?
  !current_user.nil?
end

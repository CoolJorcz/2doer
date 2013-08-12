def current_user
  @_current_user ||= User.find(session[:id])
end

def logged_in?
  !current_user.nil?
end

def strip_handle(handle)
  handle.gsub(/(@)/,"")
end


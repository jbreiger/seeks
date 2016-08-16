class ApplicationController < ActionController::Base
  	def require_correct_user
    user = User.find(params[:id])
    redirect_to "/users/#{current_user.id}" if current_user != user
  	end
  #end
   def require_login
    redirect_to '/sessions/new' if session[:id] == nil
   end 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   def current_user
    User.find(session[:id]) if session[:id]
  end
  helper_method :current_user
end
#   protect_from_forgery with: :exception
# end

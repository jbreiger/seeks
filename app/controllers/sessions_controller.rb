class SessionsController < ApplicationController
  def new
  end
  def create
  	#@user= User.create(email: params[:session][:Email], password: params[:session][:password])# need to come back to
  	
  	@user= User.find_by_email(params[:sessions][:email])
  	#@last_user=User.find_by_email(params[:sessions][:email])
    #puts @user.name
  	if @user && @user.authenticate(params[:sessions][:password])
  		session[:id]= @user.id
  		puts @user.id
  		redirect_to "/users/#{@user.id}"
  			
  	else 
  		puts "Wrong" 
  		flash[:errors]= ["Invalid"]
  		redirect_to "/sessions/new"
  	#  @user= User.create(params.require[:sessions].permit(:email, :password))
  	# @password= params [:sessions][:password]
  	# @password= @password.password_digest
  	# @password.authenticate()
  	# puts @user.id
  	#redirect_to "/sessions/new"
  	end
  	#session[:id]= user.id
  	#puts session[:id]	
end
def destroy
  session[:id] = nil
  puts "deleted session"
  redirect_to "/sessions/new"
end
end
# <% if flash[:errors] %>
#   <% flash[:errors].each do |e| %>
#     <p><%= e %></p>
#   <% end %>
# <% end %>


#   user = User.find_by_email(params[:email])

#     if user && user.authenticate(params[:password])
#       session[:user_id] = user.id
#       redirect_to user
#     else
#       flash[:errors] = ["Invalid combination"]
#       redirect_to new_session_path
#     end
#   end
# end
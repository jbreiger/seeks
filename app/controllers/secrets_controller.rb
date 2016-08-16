class SecretsController < ApplicationController
 before_action :require_login, only: [:index, :create, :destroy]
def index
	@secrets= Secret.all
	@user= User.find(session[:id])
end
def create
	puts session[:id]
	@user= User.find(session[:id])
	@secret= @user.secrets.new(secret_params)
	@secret.save
	redirect_to "/users/#{@user.id}"
end	
def destroy
	#@user= User.find(session[:id])
	@secret= Secret.find(params[:id])
	@secret.destroy if @secret.user == current_user
	redirect_to "/users/#{current_user.id}"
end
def secret_params
 params.require(:secret).permit(:content)
end
end
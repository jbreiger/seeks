class UsersController < ApplicationController
before_action :require_login, except: [:new, :create]
before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def new
  		#@user=User.find(session[:id])
  	end

  def index
  end
  def show
  	 if session[:id]
  	  @user=User.find(session[:id])
    else 
      @user=User.find(params[:id])
  	end
    @secrets= @user.secrets
    @secrets_liked= @user.secrets_liked
  end
  def create
  	@user= User.new(user_params)
  	if @user.save
      session[:id]= @user.id
  		redirect_to "/users/#{@user.id}"
  	else 
  	puts "failure"
  	flash[:errors]= ["can't be blank", "invalid"]
  	redirect_to "/users/new"

  	end	
  end
  def edit
    @user= User.find(params[:id])
  end
  def update
    @user=User.find(params[:id])
    puts @user.name
    @user.update(user_params)
    redirect_to "/users/#{@user.id}/edit"

  end
  def destroy
    @user= User.find(params[:id])
    @user.destroy
    session[:id]= nil
    redirect_to "/sessions/new"
  end
  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

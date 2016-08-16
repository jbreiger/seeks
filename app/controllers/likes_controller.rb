class LikesController < ApplicationController
before_action :require_login
#before_action :require_correct_user, only: [:create,destroy]
before_action :require_correct_user, except: [:create,:destroy]


	def create
		@secret= Secret.find(params[:secret_id])
		@user= User.find(session[:id])
		@secrets_liked= @user.secrets_liked
		@secrets_liked.each do |x|
			@id= x.id
			if x.id==@secret.id	
				@already = false
				puts "dont like it already liked"
			end		
		end
		if @already !=false
			puts "going to like"
			Like.create(user: @user, secret: @secret)
		end
		redirect_to "/secrets"
	end
	def destroy
		@secret= Secret.find(params[:id])
		@user= User.find(session[:id])
		@like= Like.find_by(user:@user, secret: @secret)
		@like.destroy
		redirect_to "/secrets"
		# @secret= Secret.find(params(:id))
		# @secret.likes
		# @like.destroy
	end
	# def likes_params
 #      params.require(:secret).permit(:, :email, :password, :password_confirmation)
 #    end
end

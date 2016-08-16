require 'rails_helper'

RSpec.describe LikesController, type: :controller do

before do
    user= create_user
    secret= user.secrets.create(content: "heres a secret")

   @like= user.likes.create(user: user, secret: secret)
  end

  describe "when not logged in" do
  	before do 
  		session[:id]=nil
  	end
  	it "cant go to create" do 	
    post :create
    expect(response).to redirect_to("/sessions/new")
  end
    it "cannot access destroy" do
      delete :destroy, id: @like
    end
end

describe "when signed in as the wrong user" do
	before do 
		@wrong_user= create_user
		@user= create_user
		session[:id]= @user.id
	end	
	it "the correct user cant create or destroy like" do
		delete :destroy, id: @user
		expect(response).to redirect_to("/users/#{@wrong_user.id}")
	end
end
end
#end

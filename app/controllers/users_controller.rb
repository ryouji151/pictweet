class UsersController < ApplicationController
 
    def destroy
    sign_out
    redirect_to root_url
  end
 
 def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets.order("created_at DESC").page(params[:page]).per(5)
  end
end
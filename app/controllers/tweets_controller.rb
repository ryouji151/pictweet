class TweetsController < ApplicationController
     before_action :move_to_index, except: [:index, :show, :search]
    def index
        @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(3) #allは省略できる
    end
    
    def new
         @tweet = Tweet.new
    end
   
     def show
    @tweet = Tweet.find(params[:id])
     @comments = @tweet.comments.includes(:user)
     
    end
    
    def create
       
        Tweet.create(image: tweets_params[:image],text: tweets_params[:text],user_id: current_user.id)
    end
    
    def destroy
        
        tweet = Tweet.find(params[:id])
      tweet.destroy if tweet.user_id == current_user.id
       redirect_to root_url
    
end

def edit
     @tweet = Tweet.find(params[:id])
end

 def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweets_params)
    end
  end
  
   def search
    @tweets = Tweet.search(params[:keyword]).page(params[:page]).per(3)
  end
  
    
    private
    def tweets_params
       
       
         params.permit(:image, :text)
    end
    
   def move_to_index
       redirect_to action: :index unless user_signed_in?
   end
        
end

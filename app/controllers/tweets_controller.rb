class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :valid_user?, only:[:edit,:update,:destroy]

  respond_to :html

  def index
    @tweets = Tweet.all
    respond_with(@tweets)
  end

  def show
    respond_with(@tweet)
  end

  def new
    @tweet = Tweet.new
    respond_with(@tweet)
  end

  def edit
   
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.save
    respond_with(@tweet)
  end

  def update
    @tweet.update(tweet_params)
    respond_with(@tweet)
  end

  def destroy
    @tweet.destroy
    respond_with(@tweet)
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end

    def valid_user?
        unless (current_user.admin) || (@tweet.user_id == current_user.id) 
          redirect_to tweets_path
        end
    end
end

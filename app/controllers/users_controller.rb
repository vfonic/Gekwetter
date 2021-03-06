class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def following
    @users = @user.following.page params[:page]
    @following = current_user.following if user_signed_in?
    @follow_type = 'following'
    render :follow
  end

  def followers
    @users = @user.followers.page params[:page]
    @following = current_user.following if user_signed_in?
    @follow_type = 'followers'
    render :follow
  end

  def index
    @users = User.page params[:page]
    @following = current_user.following if user_signed_in?
  end

  def show
    @microposts = @user.microposts.page params[:page]
  end

  private
    def set_user
      @user = User.friendly.find(params[:id])
    end
end

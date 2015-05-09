class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def following
    @users = @user.following
    @follow_type = "following"
    render :follow
  end

  def followers
    @users = @user.followers
    @follow_type = "followers"
    render :follow
  end

  def index
    @users = User.all
  end

  def show
    @microposts = @user.microposts
  end

  private
    def set_user
      @user = User.friendly.find(params[:id])
    end
end

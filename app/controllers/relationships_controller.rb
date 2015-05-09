class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow!(@user)
    redirect_to :back, notice: "Following #{@user.username}."
  end

  def destroy
    current_user.unfollow!(@user)
    redirect_to :back, notice: "Unfollowed #{@user.username}."
  end

  private
    def set_user
      @user = User.friendly.find(params[:username])
    end
end

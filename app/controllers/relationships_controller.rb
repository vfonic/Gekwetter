class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def follow
    current_user.follow!(@user)
    redirect_to :back, notice: "Followed #{@user.username}"
  end

  def unfollow
    current_user.unfollow!(@user)
    redirect_to :back, notice: "Unfollowed #{@user.username}"
  end

  private
    def set_user
      @user = User.find_by_username(params[:username])
    end
end

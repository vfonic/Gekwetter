class Api::V1::RelationshipsController < Api::V1::ApiController
  before_action :set_user

  def followers
    render json: @user.followers
  end

  def following
    render json: @user.following
  end

  private
    def set_user
      @user = User.find_by_username(params[:username])
    end
end

class Api::V1::RelationshipsController < Api::V1::ApiController
  before_action :set_user

  after_action only: [:following, :followers] { set_pagination_header(:follow) }

  def followers
    @follow = @user.followers.page(params[:page])
    render json: @follow
  end

  def following
    @follow = @user.following.page(params[:page])
    render json: @follow
  end

  private
    def set_user
      @user = User.friendly.find(params[:username])
    end
end

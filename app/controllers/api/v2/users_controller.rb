class Api::V1::UsersController < Api::V1::ApiController
  after_action only: [:show] { set_pagination_header(:microposts) }

  def show
    @user = User.friendly.find(params[:username])
    @microposts = @user.microposts.page params[:page]
    render json: @microposts
  end

  def index
    @users = User.page params[:page]
    # @following = current_user.following if user_signed_in?
    render json: @users
  end
end

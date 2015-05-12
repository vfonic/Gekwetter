class Api::V1::UsersController < Api::V1::ApiController
  after_filter only: [:show] { set_pagination_header(:microposts) }

  def show
    @user = User.friendly.find(params[:username])
    @microposts = @user.microposts.page params[:page]
    render json: @microposts
  end
end

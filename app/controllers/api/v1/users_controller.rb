class Api::V1::UsersController < Api::V1::ApiController
  def show
    @user = User.friendly.find(params[:username])
    @microposts = @user.microposts
    render json: @microposts
  end
end

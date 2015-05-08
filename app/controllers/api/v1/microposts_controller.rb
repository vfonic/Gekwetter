class Api::V1::MicropostsController < Api::V1::ApiController
  def index
    @user = User.find_by_username(params[:username])
    @microposts = @user.microposts
    render json: @microposts
  end
end

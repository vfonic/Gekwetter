class Api::V1::MicropostsController < Api::V1::ApiController
  def index
    @user = User.friendly.find(params[:username])
    @microposts = @user.microposts
    render json: @microposts
  end
end

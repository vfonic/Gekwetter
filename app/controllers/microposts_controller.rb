class MicropostsController < ApplicationController
  before_action :set_microposts, only: :timeline
  before_action :authenticate_user!

  def timeline
    render nothing: true
  end

  def create
    @micropost = Micropost.new(micropost_params)
    @micropost.user = current_user

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to user_path(current_user), notice: 'Status updated.' }
        format.json { render :show, status: :created, location: @micropost }
      else
        format.html { redirect_to :back, alert: @micropost.errors.full_messages.join }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @micropost = current_user.microposts.find(params[:id])
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Status deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_microposts
      @microposts = Micropost.timeline(current_user, params[:page])
    end

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end

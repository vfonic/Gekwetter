class MicropostsController < ApplicationController
  before_action :set_microposts, only: :index

  # GET /microposts
  # GET /microposts.json
  def index
  end

  # POST /microposts
  # POST /microposts.json
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

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost = current_user.microposts.find(params[:id])
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Status deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_microposts
      @microposts = Micropost.timeline(current_user, params[:page])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end

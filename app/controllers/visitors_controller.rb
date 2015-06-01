class VisitorsController < ApplicationController
  def index
    @microposts = Micropost.page params[:page]

    respond_to do |format|
      format.html
      format.json { render json: @microposts }
    end
  end
end

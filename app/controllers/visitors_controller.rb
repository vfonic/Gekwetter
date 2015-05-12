class VisitorsController < ApplicationController
  def index
    @microposts = Micropost.page params[:page]
  end
end

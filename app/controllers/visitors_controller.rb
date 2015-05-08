class VisitorsController < ApplicationController
  def index
    @microposts = Micropost.all
  end
end

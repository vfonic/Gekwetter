class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :admin_only, except: [:show, :index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end

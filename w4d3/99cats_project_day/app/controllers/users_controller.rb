class UsersController < ApplicationController
  before_action :reject_login, only: [:new, :create]

  def new
    render :new
    #need to make view still with the form
  end

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      flash[:errors] = ['failed to create user']
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end

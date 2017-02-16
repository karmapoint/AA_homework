class UsersController < ApplicationController

  def new # Registration page with Form
    @user = User.new
    render :new
  end

  def create # Processes registration form
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
      return
    else
      flash.now[:errors] = ['failed to create user']
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:password, :email)
  end

end

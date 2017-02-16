class SessionsController < ApplicationController

  def new #- Login Page with form
    render:new
  end

  def create #- prcoesses login Form
    @user = User.find_by_credentials(params[:session][:email], params[:session][:password])

    if @user.nil?
      flash.now[:errors] = ["Incorrect credentials"]
      render :new
    else
      login_user!(@user)
      @user = current_user
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

end

class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    # @user = User.find_by_credentials(session_params[:username],
    # =>                              session_params[:password])
    if @user
      login(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ['Invalid Credentials']
      render :new
    end
  end

  def destroy
    logout
    redirect_to subs_url
  end

  # private

  # def session_params
  #   params.require(:user).permit(:username, :password)
  # end
end

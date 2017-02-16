class SessionsController < ApplicationController
  before_action :reject_login, only: [:new, :create]

  def new

    render :new
    # need to make a view still with the form
  end

  def create
    #verify username/password
    @user = User.find_by_credentials(params[:session][:username],
            params[:session][:password])

    if @user.nil?
      flash[:errors] = ['incorrect username or password']
      redirect_to new_session_url
    else
      # reset session_token
      @user.reset_session_token!
      # update session hash with new session token
      login_user!(@user)
      # redirect to cats index page
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end

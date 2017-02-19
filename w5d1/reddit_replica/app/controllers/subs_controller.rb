class SubsController < ApplicationController
  before_action :check_moderator?, only:[:edit, :update]
  before_action :logged_in?, only:[:new, :create]


  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    #fail
    if @sub
      render :show
      #redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :index
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    # @user = User.find_by_session_token(session[:session_token])
    #new_user_params = sub_params.merge({user_id: @user.id})

    @sub = Sub.new(sub_params)
    #@sub = Sub.new(new_user_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    #boom!
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description,:user_id)
  end

  def check_moderator?
    @sub = Sub.find_by_id(params[:id])
    unless current_user.id == @sub.user_id
      flash[:errors] = ["You are not the moderator of this sub"]
      redirect_to subs_url
    end

  end

end

class PostsController < ApplicationController

  before_action :check_author?, only:[:edit, :update]
  before_action :logged_in?, only:[:new, :create]


  def show
    @post = Post.find_by_id(params[:id])
    #fail
    if @post
      render :show
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to subs_url
    end
  end

  def new
    @post = Post.new(sub_id: params[:sub_id])
    render :new
  end

  def create
    # @user = User.find_by_session_token(session[:session_token])
    #new_user_params = post_params.merge({user_id: @user.id})

    @post = Post.new(post_params)
    #@post = Post.new(new_user_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    #boom!
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :user_id, :sub_id)
  end

  def check_author?
    @post = Post.find_by_id(params[:id])
    unless current_user.id == @post.user_id
      flash[:errors] = ["You are not the author of this post"]
      redirect_to subs_url
    end

  end
end

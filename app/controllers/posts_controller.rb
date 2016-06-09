class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      flash[:notice] = 'Access denied as your not owner of this post'
      redirect_to @post
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user

    redirect_to @post
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user

    redirect_to @post
  end

  def post_owner
    @post = Post.find(params[:id])

    unless @post.user == current_user
      flash[:notice] = 'Access denied as your not owner of this post'
      redirect_to @post
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :link, :description, :image)
  end
end

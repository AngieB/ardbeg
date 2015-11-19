class Api::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages.join('. '), status: :not_acceptable
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages.join('. '), status: :not_acceptable
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: @post
    else
      render json: @post.errors.full_messages.join('. '), status: :not_acceptable
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :title, :body)
  end
end

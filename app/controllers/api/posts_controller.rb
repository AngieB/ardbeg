class Api::PostsController < ApplicationController

  def index
    @posts = Post.all
    respond_to do |format|
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.json { render json: @post }
      end
    else
      respond_to do |format|
        format.json { render json: @post.errors, status: :not_acceptable }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      respond_to do |format|
        format.json { render json: @post }
      end
    else
      respond_to do |format|
        format.json { render json: @post.errors, status: :not_acceptable }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      respond_to do |format|
        format.json { render json: @post }
      end
    else
      respond_to do |format|
        format.json { render json: @post.errors, status: :not_acceptable }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :title, :body)
  end
end

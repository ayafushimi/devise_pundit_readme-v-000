class PostsController < ApplicationController
  def index
    @posts = policy_scope(Post)
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(permitted_attributes(@post))
      redirect_to @post
    else
      render :edit
    end
  end
end

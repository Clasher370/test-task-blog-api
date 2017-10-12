class PostsController < ApplicationController
  def create
    user = User.find_by(login: params[:login]) || User.create(login: params[:login])
    post = user.posts.build(post_params)
    if post.save
      render json: post
    else
      render json: post.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :content, :ip)
  end
end

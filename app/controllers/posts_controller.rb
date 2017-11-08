class PostsController < ApplicationController
  def create
    user = User.find_or_create_by(login: params[:login])
    post = user.posts.build(post_params)
    if post.save
      render json: post, status: :ok
    else
      render json: { "errors" => post.errors.messages }, status: :unprocessable_entity
    end
  end

  def top_rated
    posts = Post.average_rating.limit(params[:limit])
    render json: posts, status: :ok
  end

  def ip_with_more_when_one_users
    object = IpsWithLogin.create_object
    render json: object, status: :ok
  end

  private

  def post_params
    params.permit(:title, :content, :ip)
  end
end

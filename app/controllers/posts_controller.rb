class PostsController < ApplicationController
  def create
    post = PostCreate.new(params)
    result = post.create
    render json: result, status: post.status
  end

  def top_rated
    posts = TopRatedPosts.return_posts(params[:limit])
    render json: posts, status: :ok
  end

  def ip_with_more_when_one_users
    object = IpsWithLogin.create_object
    render json: object, status: :ok
  end
end

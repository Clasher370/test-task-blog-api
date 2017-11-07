class RatingsController < ApplicationController
  def rate_post
    rating = Rating.new(rating_params)
    if rating.save
      avg_rate = Post.average_rating.find(params[:post_id])
      render json: { avg_rate.id => avg_rate.rating }, status: :ok
    else
      render json: rating.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def rating_params
    params.permit(:post_id, :rate)
  end
end

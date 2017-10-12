class RatingsController < ApplicationController
  def create
    rating = Rating.new(rating_params)
    if rating.save
      post_ratings = Rating.where('post_id = ?', params[:post_id]).pluck(:value)
      sum_of_rating = post_ratings.inject(0) { |e, n| e += n }.to_f
      average = sum_of_rating / post_ratings.count
      render json: average
    else
      render json: rating.errors.messages
    end
  end

  private

  def rating_params
    params.permit(:post_id, :value)
  end
end

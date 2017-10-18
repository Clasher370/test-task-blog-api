class RatingsController < ApplicationController
  def rate_or_create
    rating = RatePost.new(params[:post_id], params[:rating])
    result = rating.get_rating
    render json: result, status: rating.status
  end
end

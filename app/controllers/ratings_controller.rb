class RatingsController < ApplicationController
  def create
    user_rating = params[:rating].to_i
    if [*1..5].include? user_rating
      if rating = Rating.find_by(post_id: params[:post_id])
        new_count = rating.rating_count + 1
        average = (rating.post_rating * rating.rating_count + user_rating) / new_count
        new_average = sprintf('%.1f', average)
        rating.update(post_rating: new_average, rating_count: new_count)
        render json: { average_rating: rating.post_rating }, status: :ok
      else
        new_rating = Rating.new(post_id: params[:post_id], post_rating: params[:rating].to_f)
        if new_rating.save
          render json: { average_rating: new_rating.post_rating }, status: :ok
        else
          render json: new_rating.errors.messages, status: :unprocessable_entity
        end
      end
    else
      render json: { error: 'post_rating must be number from 1 to 5' }, status: :unprocessable_entity
    end
  end
end

class RatePost
  attr_reader :status

  def initialize(post_id, rating)
    @post_id = post_id
    @rating = rating
  end

  def get_rating
  user_rating = @rating.to_i
    if [*1..5].include? user_rating
      if rating = Rating.find_by(post_id: @post_id)
        new_count = rating.rating_count + 1
        average = (rating.post_rating * rating.rating_count + user_rating) / new_count
        new_average = sprintf('%.1f', average)
        rating.update(post_rating: new_average, rating_count: new_count)
        @status = :ok
        { average_rating: rating.post_rating }
      else
        new_rating = Rating.new(post_id: @post_id, post_rating: @rating.to_f)
        if new_rating.save
          @status = :ok
          { average_rating: new_rating.post_rating }
        else
          @status = :unprocessable_entity
          new_rating.errors.messages
        end
      end
    else
      @status = :unprocessable_entity
      { error: 'post_rating must be number from 1 to 5' }
    end
  end
end

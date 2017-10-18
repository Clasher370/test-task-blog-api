class TopRatedPosts
  def self.return_posts(limit)
    Rating.includes(:post).order('post_rating DESC').first(limit).map(&:post)
  end
end

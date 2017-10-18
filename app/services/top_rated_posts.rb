class TopRatedPosts
  def self.return_posts(limit)
    limit = limit ? false : limit
    Post.joins(:ratings).select(:title, :content).order('post_rating DESC').limit(limit)
  end
end

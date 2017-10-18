class TopRatedPosts
  def self.return_posts(limit)
    Post.joins(:ratings).select(:title, :content).order('post_rating DESC').limit(limit)
  end
end

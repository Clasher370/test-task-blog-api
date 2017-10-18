class IpsWithLogin
  def self.create_object
    ip = Post.select(:ip).group(:ip).having('Count(DISTINCT user_id) > 1').pluck(:ip)
    obj = []
    ip.each do |i|
      logins = User.joins(:posts).select(:login).where('ip = ?', i).pluck(:login).uniq
      obj << { 'ip' => i, 'login' => logins}
    end
    obj
  end
end

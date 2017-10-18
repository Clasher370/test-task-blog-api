class PostUserCreate
  def self.user(login)
    User.find_by(login: login) || User.create(login: login)
  end
end

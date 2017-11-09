class User < ApplicationRecord
  has_many :posts

  validates_presence_of :login

  def self.logins_by_ip
    User.find_by_sql ['SELECT posts.ip, users.login
                       FROM users
                       JOIN posts
                       ON users.id = posts.user_id
                       AND posts.ip
                       IN (SELECT ip
                           FROM posts
                           GROUP BY ip
                           HAVING COUNT(DISTINCT user_id) > 1)
                       ORDER BY posts.ip']
  end
end

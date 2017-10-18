class PostCreate
  attr_reader :status

  def initialize(options = {})
    @login = options[:login]
    @title = options[:title]
    @content = options[:content]
    @ip = options[:ip]
  end

  def create
    user = PostUserCreate.user(@login)
    post = user.posts.build(title: @title, content: @content, ip: @ip)
    if post.save
      @status = :ok
      post
    else
      @status = :unprocessable_entity
      post.errors.messages
    end
  end
end

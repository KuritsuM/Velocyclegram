class LastCreatedPostsService
  def initialize(post_limit = 10)
    @post_limit = post_limit
  end

  def get_posts
    Post.limit(@post_limit).order('id desc')
  end
end
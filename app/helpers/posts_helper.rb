module PostsHelper

  def cache_key_for_posts
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/all-#{count}-#{max_updated_at}"
  end

  def as_presentors(posts)
    posts.map { |x| PostPresentor.new x }
  end

end

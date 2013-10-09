module PostsHelper

  def cache_key_for_posts
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/all-#{count}-#{max_updated_at}"
  end

  def cache_key_for_tag(collection, tag_name)
    count          = collection.count
    max_updated_at = collection.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/#{tag_name}-#{count}-#{max_updated_at}"
  end

  def as_presenters(posts)
    posts.map { |x| PostPresentor.new x }
  end

end

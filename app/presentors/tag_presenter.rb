class TagPresenter < SimpleDelegator

  def posts
    __tag.posts.with_tags.as_presenters
  end

  private

  def __tag
    __getobj__
  end

end

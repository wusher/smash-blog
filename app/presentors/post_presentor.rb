class PostPresentor < SimpleDelegator

  def pubdate
    super.try(:strftime,"%m/%d/%y")
  end

  def slug_id
    __post.slug || __post.id
  end

  def published
    __post.published? ? "Published" : "Work in progress"
  end


  private

  def __post
    __getobj__
  end

end

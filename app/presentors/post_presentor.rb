class PostPresentor < SimpleDelegator

  def pubdate
    super.try(:strftime,"%m/%d/%y")
  end

  def pubday
    __post.pubdate.day.ordinalize
  end

  def slug_id
    __post.slug || __post.id
  end

  def published
    __post.published? ? "Published" : "Work in progress"
  end

  def tags
    __post.tags.pluck(:name).sort
  end


  private

  def __post
    __getobj__
  end

end

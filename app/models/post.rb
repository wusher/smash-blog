class Post < ActiveRecord::Base
  attr_accessible :body, :pubdate, :title, :published

  validates :slug, :presence => true, :uniqueness => { case_sensitive: false }
  validates :title, :presence => true, :if => :published?
  validates :pubdate, :presence => true, :if => :published?

  before_validation :update_html
  before_validation :update_slug

  default_scope order("pubdate is null desc").order("pubdate desc")
  scope :published, where(published: true)

  def publish!
    if self.publish
      true
    else
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def publish
    self.pubdate ||= Time.now
    self.published = true
    self.save
  end

  private

  def update_html
    self.body_html = TextParser.new(self.body).to_html
  end

  def update_slug
    self.slug = Slugify.new(self.title).compute
  end
end

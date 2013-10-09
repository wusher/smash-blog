class Post < ActiveRecord::Base

  validates :slug, :presence => true, :uniqueness => { case_sensitive: false }, :if => :published?
  validates :title, :presence => true, :if => :published?
  validates :pubdate, :presence => true, :if => :published?

  before_validation :update_html
  before_validation :update_slug

  default_scope -> { order("published").order("pubdate is null desc").order("pubdate desc") }
  scope :published, -> { where(published: true) }
  scope :tagged, ->(tag_name) { joins(:tags).where("tags.name like ?", tag_name) }
  scope :with_tags, -> { includes(:tags) }

  has_many :tags, through: :post_tag
  has_many :post_tag

  def self.as_presenters(presenter=nil)
    all.map { |x| x.as_presenters(presenter)}
  end

  def as_presenters(presenter=nil)
    presenter ||= PostPresentor
    presenter.new(self)
  end

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

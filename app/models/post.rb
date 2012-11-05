class Post < ActiveRecord::Base
  attr_accessible :body, :body_html, :published, :pubdate, :slug, :title


  validates :slug, :presence => true, :uniqueness => { case_sensitive: false } , :if => :published?
  validates :title, :presence => true, :if => :published?
  validates :pubdate, :presence => true, :if => :published?
  
  before_validation :update_html
  before_validation :update_slug

  def publish!
    publish_me(true)
  end
  def publish
    publish_me(false)
  end



  private 
  
  def update_html
    self.body_html = TextParser.new(self.body).to_html
  end

  def update_slug 
    self.slug = Slugify.new(self.title).compute
  end

  def publish_me(raise_exceptions)
    self.pubdate ||= Time.now
    self.published = true 
    if raise_exceptions
      self.save!
    else 
      self.save
    end
  end

end

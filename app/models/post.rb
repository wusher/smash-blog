class Post < ActiveRecord::Base
  attr_accessible :body, :body_html, :published, :pubdate, :slug, :title


  validates :slug, :presence => true, :uniqueness => { case_sensitive: false } , :if => :published?
  validates :title, :presence => true, :if => :published?
  validates :pubdate, :presence => true, :if => :published?
  
  before_validation :update_html
  before_validation :update_slug

  def publish!
    self.pubdate ||= Time.now
    self.published = true 
    self.save
  end

  def slugify(raw_text)
    return unless raw_text
    raw_text.gsub(/[^\w\/]|[!\(\)\.|\/]+/, ' '). # concert special chars to spaces 
             strip. # remove trailing spaces 
             downcase. # fix case
             gsub(/\ +/, '-') # concert groups of spaces to dashes
  end

  def markupify(markdown_text) 
    return unless markdown_text
    TextParser.new(markdown_text).to_html
  end

  private 
  
  def update_html
    self.body_html = markupify(self.body) 
  end

  def update_slug 
    self.slug = slugify(self.title)
  end

end

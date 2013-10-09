class Tag < ActiveRecord::Base
  has_many :posts, through: :post_tag
  has_many :post_tag

  scope :active, -> { where("tags.posts_count > 0") }

  def self.as_presenters(presenter=nil)
    presenter ||= TagPresenter
    all.map { |x| presenter.new x }
  end

  def as_presenter(presenter=nil)
    presenter ||= TagPresenter
    presenter.new self
  end

end

class PostTag < ActiveRecord::Base
  belongs_to :tag, counter_cache: :posts_count
  belongs_to :post
end

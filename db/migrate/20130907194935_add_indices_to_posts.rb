class AddIndicesToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :slug
    add_index :posts, :pubdate, order: { pubdate: "desc" }
    add_index :posts, :published, order: { published: "desc" }
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string  :title
      t.string  :slug
      t.text  :body
      t.text  :body_html
      t.date    :pubdate
      t.boolean :published

      t.timestamps
    end
  end
end

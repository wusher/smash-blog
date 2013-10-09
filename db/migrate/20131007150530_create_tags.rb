class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :posts_count

      t.timestamps
    end
  end
end

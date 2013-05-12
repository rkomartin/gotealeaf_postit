class CreatePostCategories < ActiveRecord::Migration
  def up
    create_table :post_categories do |t|
      t.references :post, :category
    end
  end

  def down
    drop_table :post_categories
  end
end

class AddLikesUserAndPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :user_id, :integer
    add_column :likes, :post_id, :integer

    add_index :likes, :user_id
    add_index :likes, :post_id
  end
end

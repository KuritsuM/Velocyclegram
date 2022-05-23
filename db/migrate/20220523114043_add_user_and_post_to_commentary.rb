class AddUserAndPostToCommentary < ActiveRecord::Migration[6.0]
  def change
    add_column :commentaries, :user_id, :integer
    add_column :commentaries, :post_id, :integer

    add_index :commentaries, :user_id
    add_index :commentaries, :post_id
  end
end

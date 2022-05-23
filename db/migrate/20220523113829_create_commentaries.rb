class CreateCommentaries < ActiveRecord::Migration[6.0]
  def change
    create_table :commentaries do |t|
      t.text :comment_text

      t.timestamps
    end
  end
end

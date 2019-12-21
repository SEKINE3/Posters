class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.text :body
      t.string :comment_image
      t.string :comment_video

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
   	  t.integer :user_id, null: false
      t.text :body
      t.string :post_image
      t.string :post_video


      t.timestamps
    end
  end
end

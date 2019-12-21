class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :sender_id, null:false
      t.integer :recipient_id, null: false
      t.integer :post_id
      t.integer :comment_id
      t.string :status, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

      add_index :notifications, :sender_id
      add_index :notifications, :recipient_id
      add_index :notifications, :post_id
      add_index :notifications, :comment_id
  end
end

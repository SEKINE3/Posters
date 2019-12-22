class Notification < ApplicationRecord

	default_scope -> { order(created_at: :desc) } #新しい通知から受け取るため

	belongs_to :comment, optional: true #optional: trueでnilを許可
	belongs_to :post, optional: true

	belongs_to :sender, class_name: 'User', foreign_key: 'sender_id', optional: true
  	belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id', optional: true
end

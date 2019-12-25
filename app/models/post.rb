class Post < ApplicationRecord

	belongs_to :user
	has_many :favorite_users, through: :favorites, source: :user

	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :notifications, dependent: :destroy

	mount_uploader :post_image, PostImageUploader
	mount_uploader :post_video, PostVideoUploader

	validates :body, presence: true, length: { maximum: 50 }

	def favorite?(post, current_user)
		post.favorites.find_by(user_id: current_user.id)
	end

	def create_notification_favorite!(current_user)
    # すでに"いいね"されているか検索する
    tmp = Notification.where(["sender_id = ? and recipient_id = ? and post_id = ? and status = ? ", current_user.id, user_id, id, 'favorite'])
    # "いいね"されてない場合のみ、通知を作成する
    if tmp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        recipient_id: user_id,
        status: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.sender_id == notification.recipient_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

	def create_notification_by(current_user)
		notification = current_user.active_notifications.new(
			post_id:self.id,
			sender_id:self.contributer.id,
			action:"comment"
			)

			notification.save if notification.valid?
	end

	def create_notification_by(current_user)
		notification = current_user.active_notifications.new(
			post_id:self.id,
			sender_id:self.contributer.id,
			action:"follow"
			)

			notification.save if notification.valid?
	end

end

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

	def create_notification_comment!(current_user, comment_id)
    tmp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    # distinctで重複しないようにする
    tmp_ids.each do |tmp_id|
      save_notification_comment!(current_user, comment_id, tmp_id['user_id'])
    end
  end

  def save_notification_comment(current_user, comment_id, recipient_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      recipient_id: recipient_id,
      action: 'comment'
    )
    # 自分の投稿に対する自分のコメントの場合は、通知済みとする
    if notification.sender_id == notification.recipient_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end

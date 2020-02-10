class Comment < ApplicationRecord

	belongs_to :user
	belongs_to :post
	has_many :notifications, dependent: :destroy

	mount_uploader :comment_image, CommentImageUploader
	mount_uploader :comment_video, CommentVideoUploader

	validates :body, presence: true, length: { maximum: 300 }
end

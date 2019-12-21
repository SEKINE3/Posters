class Relationship < ApplicationRecord

	belongs_to :following, class_name: "User"
	belongs_to :follower, class_name: "User"
	#class_nameで"User"モデルをfollowingとfollowedの二つに分ける

	validates :following_id, presence: true
	validates :follower_id, presence: true
	#_idが空でないことを確認
end

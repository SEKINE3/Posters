class NotificationsController < ApplicationController

	def index
		@notifications = current_user.passive_notifications.page(params[:page]).per(30)
		@notifications.where(checked: false).each do |notification|
		  notification.update_attributes(checked: true)
		end
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))

		user_ids = []
		current_user.followers.each do |follower|
			follower.followers.each do |follower_follower|
				user_ids += follower_follower.active_relationships.where.not(following_id: follower.id).pluck(:following_id)
			end
		end
		uniq_user_ids = user_ids.uniq.sample(3)
		@follow_follows = User.find(uniq_user_ids) # アクティブレコードで取り出す場合where(id: uniq_user_ids)
	end
end

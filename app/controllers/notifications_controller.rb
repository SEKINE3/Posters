class NotificationsController < ApplicationController

	def index
		@notifications = current_user.passive_notifications.page(params[:page]).per(30)
		@notifications.where(checked: false).each do |notification|
		  notification.update_attributes(checked: true)
		end
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
	end
end

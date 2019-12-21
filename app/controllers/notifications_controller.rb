class NotificationsController < ApplicationController

	def index
		byebug
		@notifications = current_user.passive_notification.page(params[:page]).per(30)
		@notifications.where(checked: false).each do |notification|
		  notification.update_attributes(checked: true)
		end
	end
end

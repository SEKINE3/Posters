class RelationshipsController < ApplicationController

	def create
		@user = User.find(params[:follower_id])
		current_user.follow(@user)
		@user.create_notification_follow(current_user)
		redirect_to users_path
	end

	def destroy
		@user = Relationship.find(params[:id]).follower
		current_user.unfollow(@user)
		redirect_to users_path
	end
end

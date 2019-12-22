class RelationshipsController < ApplicationController

	def create
		@user = User.find(params[:follower_id])
		current_user.follow(@user)
		@user.create_notification_follow!(current_user)
		respond_to do |format|
		    format.html { redirect_to @user }
		    format.js
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).follower
		current_user.unfollow(@user)
		respond_to do |format|
		    format.html { redirect_to @user }
		    format.js
		end
	end
end

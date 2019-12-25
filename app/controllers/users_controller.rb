class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user, only:[:edit]

	def index
		@users = User.all
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
		@post = Post.new
	end

	def show
		@user = User.find(params[:id])
		@followers = @user.followers
		@followings = @user.followings
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
		@newpost = Post.new

		user_ids = []
		current_user.followers.each do |follower|
			follower.followers.each do |follower_follower|
				user_ids += follower_follower.active_relationships.where.not(following_id: follower.id).pluck(:follower_id)
			end
		end
		uniq_user_ids = user_ids.uniq.sample(3)
		@follow_follows = User.find(uniq_user_ids)
	end

	def edit
		@user = User.find(params[:id])
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to user_path(@user.id)
	end

	def destroy
		@user = User(params[:id])
		@user.destroy
		redirect_to root_path
	end

	private
	def user_params
			params.require(:user).permit(:name, :introduction, :profile_image, :back_image)
	end

	def authenticate_user
		if params[:id].to_i != current_user.id
	   		redirect_to user_path(current_user.id)
		end
	end

end

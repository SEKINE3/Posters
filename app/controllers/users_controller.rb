class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all
		@post = Post.new
	end

	def show
		@user = User.find(params[:id])
		@followers = @user.followers
		@followings = @user.followings
		@all_ranks = User.find(Relationship.group(:follower_id).order('count(follower_id) desc').limit(3).pluck(:follower_id))
		@post = Post.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to user_path(@user.id)
	end

	def destroy
		@user = User(params[:id])
		@user.destroy
		redirect_to posts_path
	end

	private
		def user_params
			params.require(:user).permit(:name, :introduction, :profile_image, :back_image)
		end

end

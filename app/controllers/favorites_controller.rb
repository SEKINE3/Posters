class FavoritesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

	def create
		@fovorite = current_user.favorites.create(post_id: params[:post_id])
		@post = Post.find(params[:post_id])
		@post.create_notification_favorite!(current_user)
		respond_to do |format|
		    format.html { redirect_to @user }
		    format.js
		end
	end

	def destroy
		@fovorite = current_user.favorites.find_by(post_id: params[:id].to_i).destroy
		# @fovorite = current_user.find_by(post_id: params[:id].to_i).destroy
		@post = Post.find(params[:id])
		respond_to do |format|
		    format.html { redirect_to @user }
		    format.js
		end
	end

	private
	def favorite_params
		params.require(:favorite).permit(:user_id, :post_id)
	end
end

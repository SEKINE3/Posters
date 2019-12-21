class FavoritesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

	def create
		@fovorite = current_user.favorites.create(post_id: params[:post_id])
		@post = Post.find(params[:post_id])
		render 'index.js.erb'
		@post.create_notification_like(current_user)
	end

	def destroy
		@fovorite = current_user.find_by(post_id: params[:id].to_i).destroy
		@post = Post.find(params[:id]).post
		render 'index.js.erb'
	end

	private
	def favorite_params
		params.require(:favorite).permit(:user_id, :post_id)
	end
end

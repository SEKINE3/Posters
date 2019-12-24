class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

	def index
		@posts = Post.all.order(created_at: :desc)
		@post_rankings = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(15).pluck(:post_id))
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
	end

	def show
		@post = Post.find(params[:id])
		@newpost = Post.new
		@user = @post.user
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
		@comments = @post.comments
		@comment = Comment.new
	end

	def create
		@newpost = Post.new(post_params)
		@newpost.user_id = current_user.id
		if@post.save
		  redirect_to user_path(current_user.id)
		end
	end

	def destory
		@post = Post.find(params[:id])
		@post.destory
		redirect_to user_path(@post.user.id)
	end

	def search
		@posts = Post.where('posts.body like ?', '%' + params[:keyword] + '%').order(created_at: :desc)
		@users = User.where('users.name like ?', '%' + params[:keyword] + '%')
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
		@newpost = Post.new
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :body, :post_image, :post_video)
		end
end

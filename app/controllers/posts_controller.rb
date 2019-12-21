class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

	def index
		@posts = Post.all.order(created_at: :desc)
		# byebug
		@all_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(15).pluck(:post_id))
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@comment = Comment.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.save
	end

	def destory
		@post = Post.find(params[:id])
		@post.destory
		redirect_to user_path(@post.user.id)
	end

	def search
		@posts = Post.where('posts.body like ?', '%' + params[:keyword] + '%').order(created_at: :desc)
		@users = User.where('users.name like ?', '%' + params[:keyword] + '%')
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :body, :post_image, :post_video)
		end
end

class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:show, :create, :destroy]

	def index
		@posts = Post.all.order(created_at: :desc)
		@post_rankings = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(15).pluck(:post_id))
		@user_rankings = User.find(Relationship.group(:following_id).order('count(following_id) desc').limit(3).pluck(:following_id))
	end

	def show
		@post = Post.find(params[:id])
		@newpost = Post.new
		@user = @post.user
		@comments = @post.comments
		@comment = Comment.new
		ids = Relationship.where(following_id: current_user.id).pluck(:follower_id)
		kds = Relationship.where(following_id: ids ).where.not(follower_id: current_user.id).where.not(follower_id: ids).pluck(:follower_id).sample(3)
		@follow_follows = User.where(id: kds)
	end

	def create
		@newpost = Post.new(post_params)
		@newpost.user_id = current_user.id
		if @newpost.save
			redirect_back(fallback_location: root_path)
			flash[:success] = '投稿に成功しました。'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to user_path(@post.user.id)
	end

	def search
		@posts = Post.where('posts.body like ?', '%' + params[:keyword] + '%').order(created_at: :desc)
		@users = User.where('users.name like ?', '%' + params[:keyword] + '%')
		@newpost = Post.new
		ids = Relationship.where(following_id: current_user.id).pluck(:follower_id)
		kds = Relationship.where(following_id: ids ).where.not(follower_id: current_user.id).where.not(follower_id: ids).pluck(:follower_id).sample(3)
		@follow_follows = User.where(id: kds)
	end

	private
		def post_params
			params.require(:post).permit(:user_id, :body, :post_image, :post_video)
		end
end

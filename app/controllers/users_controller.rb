class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user, only:[:edit]

	def show
		@user = User.find(params[:id])
		@followers = @user.followers
		@followings = @user.followings
		@newpost = Post.new

		ids = Relationship.where(following_id: current_user.id).pluck(:follower_id)
		#Relationshipモデルからfollowing_id(フォローする側)がcurrent_useruserのfollower_idを配列でとる
		kds = Relationship.where(following_id: ids ).where.not(follower_id: current_user.id).where.not(follower_id: ids).pluck(:follower_id).sample(5)
		#current_userがフォローしている人がfollowing_id(フォローする側)でかつfollower_id(フォローされる側)がcurrent_user、current_userのフォローしている人でないidを配列でランダム(sample)に3つとる
		@follow_follows = User.where(id: kds)
		@follow_posts = Post.where(user_id: ids).order(created_at: :desc).page(params[:page]).per(20)
	end

	def update
		@user = User.find(params[:id])
		if 	@user.update(user_params)
		   	redirect_to user_path(@user.id)
		else
			render 'edit'
		end
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

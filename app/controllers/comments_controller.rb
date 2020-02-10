class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

	def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.new(comment_params)
    	@comment.post_id = @post.id
        if  @comment.save
            render :index
        else
            "render posts/show"
    	end
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            render :index
        end
        # redirect_back(fallback_location: root_path)
    end

    private
    	def comment_params
    		params.require(:comment).permit(:user_id, :post_id, :body, :comment_image, :comment_video)
        end

end

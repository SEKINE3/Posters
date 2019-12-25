class CommentsController < ApplicationController

	def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.new(comment_params)
    	@comment.post_id = @post.id
        if  @comment.save
            redirect_to post_path(@post.id)
        else
            "render posts/show"
    	end
    end

    private
    	def comment_params
    		params.require(:comment).permit(:user_id, :post_id, :body, :comment_image, :comment_video)
        end

end

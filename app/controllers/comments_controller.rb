class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
    	@post = @comment.post
    	if @comment.save
    		@post.create_notification_comment!(current_user, @comment.id)
    	end
    end

    private
    	def comment_params
    		params.require(:comment).permit(:user_id, :post_id, :body, :comment_image, :comment_video)

end

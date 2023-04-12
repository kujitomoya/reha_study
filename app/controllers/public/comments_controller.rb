class Public::CommentsController < ApplicationController
  def create
    impression = Impression.find(params[:impression_id])
    comment = current_customer.comments.new(comment_params)
    comment.impression_id = impression.id
    comment.save
    redirect_to impression_path(impression)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to impression_path(params[:impression_id])
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
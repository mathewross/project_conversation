class RepliesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
    @project = Project.find(params[:reply][:project_id])
    @comment = Comment.find(params[:reply][:comment_id])
    @reply = @comment.replies.build(replies_params)
    @reply.user = current_user

    respond_to do |format|
      if @reply.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("replies-#{@comment.id}", partial: 'replies/reply', locals: {reply: @reply}) }
        format.html { redirect_to project_path(@project), notice: "Reply was successfully created." }
      else
        format.html { render :new, status: 422 }
      end
    end
  end

  private

  def replies_params
    params.require(:reply).permit(:name, :message, :project_id, :comment_id)
  end
end
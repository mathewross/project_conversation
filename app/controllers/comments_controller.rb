class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:comment][:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.append("updates", partial: 'projects/update', locals: {update: @comment}) }
        format.html { redirect_to project_path(@project), notice: "Comment was successfully created." }
      else
        format.html { render :new, status: 422 }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :message, :project_id)
  end
end
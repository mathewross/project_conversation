class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find(params[:id])
    @comment = Comment.new
    @reply = Reply.new
  end

  def index
    @all_projects = Project.all
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'Project was successfully created.'
    else
      render :new, status: 422
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    previous_status = @project.status

    if @project.update(project_params)
      @project.updates.create(
        user_id: current_user.id,
        message: "Status updated from: #{previous_status}, to: #{@project.status}"
      ) if previous_status != @project.status

      redirect_to project_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  def join
    @project = Project.find(params[:project_id])
    if ProjectUser.create(user_id: current_user.id, project_id: @project.id
    )
      redirect_to projects_path, notice: "Successfully joined project #{@project.name}."
    else
      redirect_to projects_path, notice: "Unable to join project #{@project.name}."
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :status)
  end
end

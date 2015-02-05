class ProjectsController < ApplicationController
  before_filter :authenticate

  def index
    @projects = redbooth.project.all
  end

  def show
    @project = redbooth.project.find(project_id)
    @task_lists = redbooth.task_list.all(project_id: project_id)
  end

  private

  def project_id
    @project_id ||= params[:id]
  end
end

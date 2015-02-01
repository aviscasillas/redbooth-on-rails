class ProjectsController < ApplicationController
  before_filter :authenticate

  def index
    @projects = external_api.projects
  end

  def show
    @project = external_api.project(project_id)
    @task_lists = external_api.task_lists(project_id: project_id)
  end

  private

  def project_id
    @project_id ||= params[:id]
  end
end

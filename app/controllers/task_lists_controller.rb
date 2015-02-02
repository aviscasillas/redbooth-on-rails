class TaskListsController < ApplicationController
  before_filter :authenticate

  def new
    @task_list = TaskList.new(project_id: params[:project_id])
  end

  def create
    params_to_send = params.slice(:project_id).merge(params[:task_list])
    external_api.task_list_create(params_to_send)
    redirect_to project_path(project_id)
  end

  private

  def project_id
    @project_id ||= params[:project_id]
  end
end

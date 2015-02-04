class TaskListsController < ApplicationController
  before_filter :authenticate

  def new
    @task_list = TaskList.new(project_id: params[:project_id])
  end

  def create
    params_to_send = params.slice(:project_id).merge(params[:task_list])
    redbooth.task_list.create(params_to_send)
    redirect_to project_path(project_id)
  end

  private

  def project_id
    @project_id ||= params[:project_id]
  end
end

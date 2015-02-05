class TaskListsController < ApplicationController
  before_filter :authenticate

  def new
    @task_list = TaskList.new(project_id: params[:project_id])
  end

  def create
    @task_list = TaskList.new(task_list_params)
    if @task_list.valid?
      redbooth.task_list.create(task_list.to_provider)
      redirect_to project_path(project_id)
    end
    flash.now[:error] = 'You have errors in the form'
    render :new
  end

  private

  def task_list_params
    params.slice(:project_id).merge(params[:task_list])
  end

  def project_id
    @project_id ||= params[:project_id]
  end
end

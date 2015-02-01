class TaskListsController < ApplicationController
  before_filter :authenticate

  def new
    @project_id = params[:project_id]
  end
end

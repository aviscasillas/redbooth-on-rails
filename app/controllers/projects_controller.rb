class ProjectsController < ApplicationController
  before_filter :authenticate

  def index
    @projects = external_api.projects
  end
end

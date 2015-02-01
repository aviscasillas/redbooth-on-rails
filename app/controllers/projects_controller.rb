require 'redbooth_on_rails/external_api'

class ProjectsController < ApplicationController
  before_filter :authenticate

  def index
    @projects = external_api.projects
  end

  private

  def external_api
    @external_api ||= RedboothOnRails::ExternalApi.new(current_user)
  end
end

class WelcomeController < ApplicationController
  def index
    redirect_to :projects if logged_in?
  end
end

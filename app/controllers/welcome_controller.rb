class WelcomeController < ApplicationController
  # before_filter :login_required

  def index
    session[:current_location] = "welcome"
  end
end

class WelcomeController < ApplicationController
  # before_filter :login_required 
  
  def index
  end

  def about
    session[:current_location] = "welcome/about"
  end
end

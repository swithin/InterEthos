# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # Be sure to include AuthenticatedSystem in Application Controller instead
  include AuthenticatedSystem
  
  after_filter :set_charset
  def set_charset
    unless headers["Content-Type" ] =~ /charset/i
      headers["Content-Type" ] ||= ""
      headers["Content-Type" ] += "; charset=utf-8"
    end
  end

end

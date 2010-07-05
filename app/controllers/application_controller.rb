# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  # Be sure to include AuthenticatedSystem in Application Controller instead
  include AuthenticatedSystem
  # before_filter :login_from_cookie
  # before_filter :set_current_user
  # before_filter { |c| Authorization.current_user = c.current_user }

 before_filter :set_current_user
 protected
 def set_current_user
   Authorization.current_user = current_user
 end


  before_filter :set_domain
  def set_domain
    # Extract domain
    this_domain = request.domain()
	
	if this_domain == "interethos.com"
		redirect_to "http://interethos.net"
		return
	end
	if this_domain == "interethos.org"
		redirect_to "http://interethos.net"
		return
	end
  end
  
  
  # set_current_user sets the global current user for this request.  This
  # is used by model security that does not have access to the
  # controller#current_user method.  It is called as a before_filter.
  def set_current_user
    Authorization.current_user = current_user
  end
  
  
  def permission_denied
    respond_to do |format|
      flash[:error] = 'Sorry, you are not allowed to view the requested page.'
	  redirect_to ontologies_path
    end
  end
end
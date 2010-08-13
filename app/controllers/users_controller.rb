class UsersController < ApplicationController
  # before_filter :login_required
  # DO NOT enable the following "filter_resource_access" as it prevents new Users from "signup"
  # filter_resource_access
  
  filter_access_to :all
  filter_access_to :edit, :update, :attribute_check => true

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)
    session[:current_location] = users_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml

  def show
    @user = User.find(params[:id])
    session[:current_location] = users_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  # before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  

  # render new.rhtml
  def new
    @user = User.new
    if authorized?
        current_user_roles = @current_user.roles.find(:all)
        if current_user_roles.include?("admin")
            @roles_assignable = ["admin","owner","editor"]
        else
            @roles_assignable = ["owner","editor"]
        end
    else
      @roles_assignable = ["owner"]
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    
    @user_roles = Array.new
    @user_roles = @user.roles
    if authorized?
        current_user_roles = @current_user.roles
        if current_user_roles != nil 
            if current_user_roles.include?("admin")
                @roles_assignable = ["admin","owner","editor"]
            else
                @roles_assignable = ["owner","editor"]
            end
        else
              @roles_assignable = ["owner"]
        end
    else
        @roles_assignable = ["owner"]
    end
  end

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thank you for signing up!  We are sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  # def create
    # logout_keeping_session!
    # @user = User.new(params[:user])
    # success = @user && @user.save
    # if success && @user.errors.empty?
      # # Protects against session fixation attacks, causes request forgery
      # # protection if visitor resubmits an earlier form using back
      # # button. Uncomment if you understand the tradeoffs.
      # # reset session
      # self.current_user = @user # !! now logged in
            # redirect_back_or_default('/')
      # flash[:notice] = "Thank You for signing up! We are sending you an email with your activation code."
    # else
      # flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      # render :action => 'new'
    # end
  # end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    # All InterEthos users are set up as "owners" by default.
    user.roles = ["owner"]
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
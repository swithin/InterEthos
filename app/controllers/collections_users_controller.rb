class CollectionsUsersController < ApplicationController
  before_filter :login_required
  # GET /collections_users
  # GET /collections_users.xml
  def index
    @collections_users = CollectionsUser.all
    session[:current_location] = collections_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections_users }
    end
  end

  # GET /collections_users/1
  # GET /collections_users/1.xml
  def show
    @collections_user = CollectionsUser.find(params[:id])
    session[:current_location] = collections_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collections_user }
    end
  end

  # GET /collections_users/new
  # GET /collections_users/new.xml
  def new
    @user = User.find(params[:user_id])
    @collections_user = CollectionsUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collections_user }
    end
  end

  # GET /collections_users/1/edit
  def edit
    @collections_user = CollectionsUser.find(params[:id])
    @user = @collections_user.user
  end

  # POST /collections_users
  # POST /collections_users.xml
  def create
    @collections_user = CollectionsUser.new(params[:collections_user])
    @user = @collections_user.user

    respond_to do |format|
      if @collections_user.save
        flash[:notice] = 'User Collection was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @collections_user, :status => :created, :location => @collections_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collections_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collections_users/1
  # PUT /collections_users/1.xml
  def update
    @collections_user = CollectionsUser.find(params[:id])
    @user = @collections_user.user

    respond_to do |format|
      if @collections_user.update_attributes(params[:collections_user])
        flash[:notice] = 'User Collection was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collections_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collections_users/1
  # DELETE /collections_users/1.xml
  def destroy
    @collections_user = CollectionsUser.find(params[:id])
    @collections_user.destroy
    @user = @collections_user.user

    respond_to do |format|
      format.html { redirect_to(@user) }
      format.xml  { head :ok }
    end
  end
end

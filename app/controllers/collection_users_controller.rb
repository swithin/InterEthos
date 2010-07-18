class CollectionUsersController < ApplicationController
  filter_resource_access # :nested_in => :collections
  
  # GET /collections_users
  # GET /collections_users.xml
  def index
    session[:current_location] = collections_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections_users }
    end
  end

  # GET /collections_users/1
  # GET /collections_users/1.xml
  def show
    @user = CollectionsUser.find(params[:id])
    session[:current_location] = collections_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collections_user }
    end
  end

  # GET /collections_users/new
  # GET /collections_users/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collections_user }
    end
  end

  # POST /collections_users
  # POST /collections_users.xml
  def create
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

  # DELETE /collections_users/1
  # DELETE /collections_users/1.xml
  def destroy
    respond_to do |format|
      format.html { redirect_to(@user) }
      format.xml  { head :ok }
    end
  end

  # Overriding the default filter_resource_access new method:
  def user
    @user = @collection.collection_users.new(:user => current_user)
  end
end
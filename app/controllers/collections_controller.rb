class CollectionsController < ApplicationController
  # filter_resource_access is a shorthand for typical filter_access_to
  # statements and before_filters in restful controllers
  filter_resource_access # :nested_in => :collections_users
  
  # GET /collections
  # GET /collections.xml
  def index
    # Only show collections that the current user may read:
    @collections = Collection.with_permissions_to(:read)
    session[:current_location] = collections_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.xml
  def show
    # @collection is loaded in before_filter
    session[:current_location] = collections_path
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.xml
  def new
    # @collection is created in before_filter

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collection }
    end
  end

  # GET /collections/1/edit
  def edit
    # @collection is loaded in before_filter
  end

  # POST /collections
  # POST /collections.xml
  def create
    # @collection is created in before_filter

    respond_to do |format|
      if @collection.save
        flash[:notice] = 'Collection was successfully created.'
        format.html { redirect_to(collections_path) }
        format.xml  { render :xml => @collection, :status => :created, :location => @collection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collections/1
  # PUT /collections/1.xml
  def update
    # @collection is loaded in before_filter

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        flash[:notice] = 'Collection was successfully updated.'
        format.html { redirect_to(collections_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.xml
  def destroy
    # @collection is loaded in before_filter
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to(collections_url) }
      format.xml  { head :ok }
    end
  end
end
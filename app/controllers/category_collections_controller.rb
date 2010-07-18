class CategoryCollectionsController < ApplicationController
  # before_filter :login_required
  # the ":nested_in" parameters can be used to further filter the results
  filter_resource_access #:nested_in => :categories
  # GET /collection_categories
  # GET /collection_categories.xml
  def index
    @category_collections = CategoryCollection.all
    session[:current_location] = categories_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collection_categories }
    end
  end

  # GET /collection_categories/1
  # GET /collection_categories/1.xml
  def show
    @category_collection = CategoryCollection.find(params[:id])
    session[:current_location] = categories_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category_collection }
    end
  end

  # GET /collection_categories/new
  # GET /collection_categories/new.xml
  def new
    @collection = Collection.find(params[:collection_id])
    @category_collection = CategoryCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category_collection }
    end
  end

  # GET /collection_categories/1/edit
  def edit
    @collection = Collection.find(params[:id])
    @category_collection = CategoryCollection.find(params[:id])
  end

  # POST /collection_categories
  # POST /collection_categories.xml
  def create
    @category_collection = CategoryCollection.new(params[:category_collection])
    @collection = @category_collection.collection

    respond_to do |format|
      if @category_collection.save
        flash[:notice] = 'CategoryCollection was successfully created.'
        format.html { redirect_to(@collection) }
        format.xml  { render :xml => @category_collection, :status => :created, :location => @category_collection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category_collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collection_categories/1
  # PUT /collection_categories/1.xml
  def update
    @category_collection = CategoryCollection.find(params[:id])
    @collection = @category_collection.collection

    respond_to do |format|
      if @category_collection.update_attributes(params[:category_collection])
        flash[:notice] = 'CategoryCollection was successfully updated.'
        format.html { redirect_to(@collection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category_collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_categories/1
  # DELETE /collection_categories/1.xml
  def destroy
    @category_collection = CategoryCollection.find(params[:id])
    @collection = @category_collection.collection
    @category_collection.destroy

    respond_to do |format|
      format.html { redirect_to(@collection) }
      format.xml  { head :ok }
    end
  end
end

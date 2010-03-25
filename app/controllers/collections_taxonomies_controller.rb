class CollectionsTaxonomiesController < ApplicationController
  before_filter :login_required
  # GET /collections_taxonomies
  # GET /collections_taxonomies.xml
  def index
    @collections_taxonomies = CollectionsTaxonomy.all
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections_taxonomies }
    end
  end

  # GET /collections_taxonomies/1
  # GET /collections_taxonomies/1.xml
  def show
    @collections_taxonomy = CollectionsTaxonomy.find(params[:id])
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collections_taxonomy }
    end
  end

  # GET /collections_taxonomies/new
  # GET /collections_taxonomies/new.xml
  def new
    @collection = Collection.find(params[:collection_id])
    @collections_taxonomy = CollectionsTaxonomy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collections_taxonomy }
    end
  end

  # GET /collections_taxonomies/1/edit
  def edit
    @collection = Collection.find(params[:id])
    @collections_taxonomy = CollectionsTaxonomy.find(params[:id])
  end

  # POST /collections_taxonomies
  # POST /collections_taxonomies.xml
  def create
    @collections_taxonomy = CollectionsTaxonomy.new(params[:collections_taxonomy])
    @collection = @collections_taxonomy.collection

    respond_to do |format|
      if @collections_taxonomy.save
        flash[:notice] = 'CollectionsTaxonomy was successfully created.'
        format.html { redirect_to(@collection) }
        format.xml  { render :xml => @collections_taxonomy, :status => :created, :location => @collections_taxonomy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collections_taxonomy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collections_taxonomies/1
  # PUT /collections_taxonomies/1.xml
  def update
    @collections_taxonomy = CollectionsTaxonomy.find(params[:id])
    @collection = @collections_taxonomy.collection

    respond_to do |format|
      if @collections_taxonomy.update_attributes(params[:collections_taxonomy])
        flash[:notice] = 'CollectionsTaxonomy was successfully updated.'
        format.html { redirect_to(@collection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collections_taxonomy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collections_taxonomies/1
  # DELETE /collections_taxonomies/1.xml
  def destroy
    @collections_taxonomy = CollectionsTaxonomy.find(params[:id])
    @collection = @collections_taxonomy.collection
    @collections_taxonomy.destroy

    respond_to do |format|
      format.html { redirect_to(@collection) }
      format.xml  { head :ok }
    end
  end
end

class TaxonomiesController < ApplicationController
  # before_filter :login_required
  filter_resource_access

  # GET /taxonomies
  # GET /taxonomies.xml
  def index
    @taxonomies = Taxonomy.with_permissions_to(:read)
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taxonomies }
    end
  end

  # GET /taxonomies/1
  # GET /taxonomies/1.xml
  def show
    # @taxonomy is loaded in before_filter
    session[:current_location] = taxonomies_path
    @category_root_id = @taxonomy.categories.find_all_by_parent_id(1)
    @Category_tree = Category.find_all_by_parent_id(@category_root_id, :order => "name")
    @Internationalizations = Taxonomy.find_all_by_internationalization_id(@taxonomy.id, :order => "name")
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taxonomy }
    end
  end

  # GET /taxonomies/new
  # GET /taxonomies/new.xml
  def new
    # @taxonomy is created in before_filter
	if params[:internationalization_id]
      @internationalization = Taxonomy.find(params[:internationalization_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taxonomy }
    end
  end

  # GET /taxonomies/1/edit
  def edit
    # @taxonomy is loaded in before_filter
  end

  # POST /taxonomies
  # POST /taxonomies.xml
  def create
    # @taxonomy is created in before_filter

    respond_to do |format|
      if @taxonomy.save
        flash[:notice] = 'Taxonomy was successfully created.'
        format.html { redirect_to(taxonomies_url) }
        format.xml  { render :xml => @taxonomy, :status => :created, :location => @taxonomy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @taxonomy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taxonomies/1
  # PUT /taxonomies/1.xml
  def update
    # @taxonomy is loaded in before_filter

    respond_to do |format|
      if @taxonomy.update_attributes(params[:taxonomy])
        flash[:notice] = 'Taxonomy was successfully updated.'
        format.html { redirect_to(taxonomies_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @taxonomy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taxonomies/1
  # DELETE /taxonomies/1.xml
  def destroy
    # @taxonomy is loaded in before_filter
    @taxonomy.destroy

    respond_to do |format|
      format.html { redirect_to(taxonomies_url) }
      format.xml  { head :ok }
    end
  end
end
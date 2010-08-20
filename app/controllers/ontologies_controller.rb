class OntologiesController < ApplicationController
  # before_filter :login_required
  filter_resource_access

  # GET /ontologies
  # GET /ontologies.xml
  def index
    @ontologies = Ontology.with_permissions_to(:read)
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontologies }
    end
  end

  # GET /ontologies/1
  # GET /ontologies/1.xml
  def show
    # @ontology is loaded in before_filter
    session[:current_location] = ontologies_path
    @category_root_id = @ontology.categories.find_all_by_parent_id(1)
    @Category_tree = Category.find_all_by_parent_id(@category_root_id, :order => "name")
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontology }
    end
  end

  # GET /ontologies/new
  # GET /ontologies/new.xml
  def new
    # @ontology is created in before_filter
	if params[:translation_id]
      @translation = Ontology.find(params[:translation_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontology }
    end
  end

  # GET /ontologies/1/edit
  def edit
    # @ontology is loaded in before_filter
  end

  # POST /ontologies
  # POST /ontologies.xml
  def create
    # @ontology is created in before_filter

    respond_to do |format|
      if @ontology.save
        flash[:notice] = 'Ontology was successfully created.'
        format.html { redirect_to(ontologies_url) }
        format.xml  { render :xml => @ontology, :status => :created, :location => @ontology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontologies/1
  # PUT /ontologies/1.xml
  def update
    # @ontology is loaded in before_filter

    respond_to do |format|
      if @ontology.update_attributes(params[:ontology])
        flash[:notice] = 'Ontology was successfully updated.'
        format.html { redirect_to(ontologies_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontologies/1
  # DELETE /ontologies/1.xml
  def destroy
    # @ontology is loaded in before_filter
    @ontology.destroy

    respond_to do |format|
      format.html { redirect_to(ontologies_url) }
      format.xml  { head :ok }
    end
  end
end
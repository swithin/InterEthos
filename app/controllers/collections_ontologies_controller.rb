class CollectionsOntologiesController < ApplicationController
  # before_filter :login_required
  # the ":nested_in" parameters can be used to further filter the results
  filter_resource_access #:nested_in => :ontologies
  # GET /collections_ontologies
  # GET /collections_ontologies.xml
  def index
    @collections_ontologies = CollectionsOntology.all
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections_ontologies }
    end
  end

  # GET /collections_ontologies/1
  # GET /collections_ontologies/1.xml
  def show
    @collections_ontology = CollectionsOntology.find(params[:id])
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collections_ontology }
    end
  end

  # GET /collections_ontologies/new
  # GET /collections_ontologies/new.xml
  def new
    @collection = Collection.find(params[:collection_id])
    @collections_ontology = CollectionsOntology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collections_ontology }
    end
  end

  # GET /collections_ontologies/1/edit
  def edit
    @collection = Collection.find(params[:id])
    @collections_ontology = CollectionsOntology.find(params[:id])
  end

  # POST /collections_ontologies
  # POST /collections_ontologies.xml
  def create
    @collections_ontology = CollectionsOntology.new(params[:collections_ontology])
    @collection = @collections_ontology.collection

    respond_to do |format|
      if @collections_ontology.save
        flash[:notice] = 'CollectionsOntology was successfully created.'
        format.html { redirect_to(@collection) }
        format.xml  { render :xml => @collections_ontology, :status => :created, :location => @collections_ontology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collections_ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collections_ontologies/1
  # PUT /collections_ontologies/1.xml
  def update
    @collections_ontology = CollectionsOntology.find(params[:id])
    @collection = @collections_ontology.collection

    respond_to do |format|
      if @collections_ontology.update_attributes(params[:collections_ontology])
        flash[:notice] = 'CollectionsOntology was successfully updated.'
        format.html { redirect_to(@collection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collections_ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collections_ontologies/1
  # DELETE /collections_ontologies/1.xml
  def destroy
    @collections_ontology = CollectionsOntology.find(params[:id])
    @collection = @collections_ontology.collection
    @collections_ontology.destroy

    respond_to do |format|
      format.html { redirect_to(@collection) }
      format.xml  { head :ok }
    end
  end
end

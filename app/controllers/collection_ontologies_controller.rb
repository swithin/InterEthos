class CollectionOntologiesController < ApplicationController
  # before_filter :login_required
  # the ":nested_in" parameters can be used to further filter the results
  filter_resource_access #:nested_in => :ontologies
  # GET /collection_ontologies
  # GET /collection_ontologies.xml
  def index
    @collection_ontologies = CollectionOntology.all
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collection_ontologies }
    end
  end

  # GET /collection_ontologies/1
  # GET /collection_ontologies/1.xml
  def show
    @collection_ontology = CollectionOntology.find(params[:id])
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collection_ontology }
    end
  end

  # GET /collection_ontologies/new
  # GET /collection_ontologies/new.xml
  def new
    @collection = Collection.find(params[:collection_id])
    @collection_ontology = CollectionOntology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collection_ontology }
    end
  end

  # GET /collection_ontologies/1/edit
  def edit
    @collection = Collection.find(params[:id])
    @collection_ontology = CollectionOntology.find(params[:id])
  end

  # POST /collection_ontologies
  # POST /collection_ontologies.xml
  def create
    @collection_ontology = CollectionOntology.new(params[:collection_ontology])
    @collection = @collection_ontology.collection

    respond_to do |format|
      if @collection_ontology.save
        flash[:notice] = 'CollectionOntology was successfully created.'
        format.html { redirect_to(@collection) }
        format.xml  { render :xml => @collection_ontology, :status => :created, :location => @collection_ontology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collection_ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collection_ontologies/1
  # PUT /collection_ontologies/1.xml
  def update
    @collection_ontology = CollectionOntology.find(params[:id])
    @collection = @collection_ontology.collection

    respond_to do |format|
      if @collection_ontology.update_attributes(params[:collection_ontology])
        flash[:notice] = 'CollectionOntology was successfully updated.'
        format.html { redirect_to(@collection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collection_ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_ontologies/1
  # DELETE /collection_ontologies/1.xml
  def destroy
    @collection_ontology = CollectionOntology.find(params[:id])
    @collection = @collection_ontology.collection
    @collection_ontology.destroy

    respond_to do |format|
      format.html { redirect_to(@collection) }
      format.xml  { head :ok }
    end
  end
end

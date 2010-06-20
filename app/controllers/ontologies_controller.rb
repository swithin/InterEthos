class OntologiesController < ApplicationController
  # before_filter :login_required
  filter_resource_access
  # GET /ontologies
  # GET /ontologies.xml
  def index
    @ontologies = Ontology.all
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontologies }
    end
  end

  # GET /ontologies/1
  # GET /ontologies/1.xml
  def show
    @ontology = Ontology.find(params[:id])
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontology }
    end
  end

  # GET /ontologies/new
  # GET /ontologies/new.xml
  def new
    @ontology = Ontology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontology }
    end
  end

  # GET /ontologies/1/edit
  def edit
    @ontology = Ontology.find(params[:id])
  end

  # POST /ontologies
  # POST /ontologies.xml
  def create
    @ontology = Ontology.new(params[:ontology])

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
    @ontology = Ontology.find(params[:id])

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
    @ontology = Ontology.find(params[:id])
    @ontology.destroy

    respond_to do |format|
      format.html { redirect_to(ontologies_url) }
      format.xml  { head :ok }
    end
  end
end

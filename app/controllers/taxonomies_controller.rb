class TaxonomiesController < ApplicationController
  before_filter :login_required
  # GET /taxonomies
  # GET /taxonomies.xml
  def index
    @taxonomies = Taxonomy.all
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taxonomies }
    end
  end

  # GET /taxonomies/1
  # GET /taxonomies/1.xml
  def show
    @taxonomy = Taxonomy.find(params[:id])
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taxonomy }
    end
  end

  # GET /taxonomies/new
  # GET /taxonomies/new.xml
  def new
    @taxonomy = Taxonomy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taxonomy }
    end
  end

  # GET /taxonomies/1/edit
  def edit
    @taxonomy = Taxonomy.find(params[:id])
  end

  # POST /taxonomies
  # POST /taxonomies.xml
  def create
    @taxonomy = Taxonomy.new(params[:taxonomy])

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
    @taxonomy = Taxonomy.find(params[:id])

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
    @taxonomy = Taxonomy.find(params[:id])
    @taxonomy.destroy

    respond_to do |format|
      format.html { redirect_to(taxonomies_url) }
      format.xml  { head :ok }
    end
  end
end

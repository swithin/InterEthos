class CategoriesController < ApplicationController
  before_filter :login_required
  # GET /categories
  # GET /categories.xml
  helper CategoriesHelper
  def index
    @categories = Category.all
	# "branch_clicks" are incremented for each click on a non-navbar link 
	session[:branch_clicks] = 0
    session[:current_location] = categories_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
      format.json  { render :json => @categories }
    end
  end

  def tree
  	@xml = Builder::XmlMarkup.new
    @categories = Category.find(:all)
	@category_root_id = Category.find(params[:id])
	@tree = @category_root_id.children
	# "branch_clicks" are incremented for each click on a non-navbar link 
	session[:branch_clicks] = 1
    session[:current_location] = categories_path
	respond_to do |format|
	  format.html # index.html.erb
      format.xml  # tree.xml.builder
	  # format.xml  { render :xml => @tree }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])
    session[:current_location] = categories_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category.to_xml }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @taxonomy = Taxonomy.find(params[:taxonomy_id])
    @category = Category.new
    @parent_id = params[:parent_id].to_i
    session[:uroot_id] = params[:uroot_id].to_i

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    session[:uroot_id] = params[:uroot_id].to_i
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        if params[:add_similar]
          format.html { redirect_to(new_category_path(:parent_id => @category.parent_id)) }
        else
          format.html { redirect_to(:controller => 'categories', :action => 'index') }
        end
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(:controller => 'categories', :action => 'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    # did not have time to add the "...&uroot_id=#" variable to the "destroy" links.
    # session[:uroot_id] = params[:uroot_id].to_i

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end

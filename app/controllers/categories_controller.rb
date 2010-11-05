class CategoriesController < ApplicationController
  # before_filter :login_required
  filter_resource_access
  # GET /categories
  # GET /categories.xml
  helper CategoriesHelper
  def index
    # Only show categories that the current user may read:
    @categories = Category.with_permissions_to(:read)
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
    @Category_tree = Category.find_all_by_parent_id(@category_root_id, :order => "name")
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
    session[:current_location] = categories_path
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category.to_xml }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    if !params[:parent_id]
      @parent_id = 1
    else
      @parent_id = params[:parent_id]
    end
    if !params[:translation_id]
      @translation_id = 0
    else
      @translation_id = params[:translation_id]
    end
    if params[:taxonomy_id]
      @taxonomy = Taxonomy.find(params[:taxonomy_id])
    else
      @taxonomy = Category.find(params[:uroot_id]).taxonomy
    end
    session[:uroot_id] = params[:uroot_id].to_i

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @taxonomy = Category.find(params[:uroot_id]).taxonomy
    @synonyms = @category.synonyms
    session[:uroot_id] = params[:uroot_id].to_i
  end

  # POST /categories
  # POST /categories.xml
  def create
    # if @category.taxonomy.id.to_s.length > 1
      taxonomy = @category.taxonomy
    # else
      # taxonomy = Category.find(params[:uroot_id]).taxonomy
    # end
    
    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        if params[:add_similar]
          format.html { redirect_to(new_category_path(:parent_id => @category.parent_id, :uroot_id => session[:uroot_id])) }
        else
	  if Category.find_all_by_id(@category.translation_id).empty?
            format.html { redirect_to(@category.taxonomy) }
	  else
	    format.html { redirect_to(Category.find_all_by_id(@category.translation_id)[0].taxonomy) }
	  end
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
    taxonomy = @category.taxonomy
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
	if Category.find_all_by_id(@category.translation_id).empty?
	  format.html { redirect_to(@category.taxonomy) }
	else
	  format.html { redirect_to(Category.find_all_by_id(@category.translation_id)[0].taxonomy) }
	end
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
    taxonomy = @category.taxonomy
    @category.destroy
    # did not have time to add the "...&uroot_id=#" variable to the "destroy" links.
    # session[:uroot_id] = params[:uroot_id].to_i

    respond_to do |format|
      format.html { redirect_to(taxonomy) }
      format.xml  { head :ok }
    end
  end
end

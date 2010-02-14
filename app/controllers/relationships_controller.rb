class RelationshipsController < ApplicationController
  def index
    @relationships = Relationship.all
  end
  
  def show
    @relationship = Relationship.find(params[:id])
  end
  
  def new
    @relationship = Relationship.new
  end
  
  def create
    @relationship = Relationship.new(params[:relationship])
    if @relationship.save
      flash[:notice] = "Successfully created relationship."
      redirect_to @relationship
    else
      render :action => 'new'
    end
  end
  
  def edit
    @relationship = Relationship.find(params[:id])
  end
  
  def update
    @relationship = Relationship.find(params[:id])
    @category = @relationship.category_id
    if @relationship.update_attributes(params[:relationship])
      flash[:notice] = "Successfully updated relationship."
      redirect_to edit_category_path(:id => @category) 
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
    flash[:notice] = "Successfully destroyed relationship."
    redirect_to(:controller => 'categories', :action => 'show', :id => @category) 
  end
end

class RelationshipsController < ApplicationController
  before_filter :login_required
  def index
    @relationships = Relationship.all
  end
  
  def show
    @relationship = Relationship.find(params[:id])
    @category = @relationship.category
  end
  
  def new
    @relationship = Relationship.new
    @category = Category.find(params[:category_id])
  end
  
  def create
    @relationship = Relationship.new(params[:relationship])
    @category = @relationship.category
    if @relationship.save
      flash[:notice] = "Successfully created relationship."
      redirect_to edit_category_path(:id => @category, :uroot_id => session[:uroot_id]) 
    else
      render :action => 'new'
    end
  end
  
  def edit
    @relationship = Relationship.find(params[:id])
  end
  
  def update
    @relationship = Relationship.find(params[:id])
    @category = @relationship.category
    if @relationship.update_attributes(params[:relationship])
      flash[:notice] = "Successfully updated relationship."
      redirect_to edit_category_path(:id => @category, :uroot_id => session[:uroot_id]) 
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @relationship = Relationship.find(params[:id])
    @category = @relationship.category
    @relationship.destroy
    flash[:notice] = "Successfully destroyed relationship."
      redirect_to edit_category_path(:id => @category, :uroot_id => session[:uroot_id]) 
  end
end

class TaxonomiesUsersController < ApplicationController
  before_filter :login_required
  # GET /taxonomies_users
  # GET /taxonomies_users.xml
  def index
    @taxonomies_users = TaxonomiesUser.all
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taxonomies_users }
    end
  end

  # GET /taxonomies_users/1
  # GET /taxonomies_users/1.xml
  def show
    @taxonomies_user = TaxonomiesUser.find(params[:id])
    session[:current_location] = taxonomies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taxonomies_user }
    end
  end

  # GET /taxonomies_users/new
  # GET /taxonomies_users/new.xml
  def new
    @user = User.find(params[:user_id])
    @taxonomies_user = TaxonomiesUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taxonomies_user }
    end
  end

  # GET /taxonomies_users/1/edit
  def edit
    @taxonomies_user = TaxonomiesUser.find(params[:id])
    @user = @taxonomies_user.user
  end

  # POST /taxonomies_users
  # POST /taxonomies_users.xml
  def create
    @taxonomies_user = TaxonomiesUser.new(params[:taxonomies_user])
    @user = @taxonomies_user.user

    respond_to do |format|
      if @taxonomies_user.save
        flash[:notice] = 'User Taxonomy was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @taxonomies_user, :status => :created, :location => @taxonomies_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @taxonomies_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taxonomies_users/1
  # PUT /taxonomies_users/1.xml
  def update
    @taxonomies_user = TaxonomiesUser.find(params[:id])
    @user = @taxonomies_user.user

    respond_to do |format|
      if @taxonomies_user.update_attributes(params[:taxonomies_user])
        flash[:notice] = 'User Taxonomy was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @taxonomies_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taxonomies_users/1
  # DELETE /taxonomies_users/1.xml
  def destroy
    @taxonomies_user = TaxonomiesUser.find(params[:id])
    @taxonomies_user.destroy
    @user = @taxonomies_user.user

    respond_to do |format|
      format.html { redirect_to(@user) }
      format.xml  { head :ok }
    end
  end
end

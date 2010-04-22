class OntologiesUsersController < ApplicationController
  before_filter :login_required
  # GET /ontologies_users
  # GET /ontologies_users.xml
  def index
    @ontologies_users = OntologiesUser.all
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ontologies_users }
    end
  end

  # GET /ontologies_users/1
  # GET /ontologies_users/1.xml
  def show
    @ontologies_user = OntologiesUser.find(params[:id])
    session[:current_location] = ontologies_path

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ontologies_user }
    end
  end

  # GET /ontologies_users/new
  # GET /ontologies_users/new.xml
  def new
    @user = User.find(params[:user_id])
    @ontologies_user = OntologiesUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ontologies_user }
    end
  end

  # GET /ontologies_users/1/edit
  def edit
    @ontologies_user = OntologiesUser.find(params[:id])
    @user = @ontologies_user.user
  end

  # POST /ontologies_users
  # POST /ontologies_users.xml
  def create
    @ontologies_user = OntologiesUser.new(params[:ontologies_user])
    @user = @ontologies_user.user

    respond_to do |format|
      if @ontologies_user.save
        flash[:notice] = 'User Ontology was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @ontologies_user, :status => :created, :location => @ontologies_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ontologies_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ontologies_users/1
  # PUT /ontologies_users/1.xml
  def update
    @ontologies_user = OntologiesUser.find(params[:id])
    @user = @ontologies_user.user

    respond_to do |format|
      if @ontologies_user.update_attributes(params[:ontologies_user])
        flash[:notice] = 'User Ontology was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ontologies_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ontologies_users/1
  # DELETE /ontologies_users/1.xml
  def destroy
    @ontologies_user = OntologiesUser.find(params[:id])
    @ontologies_user.destroy
    @user = @ontologies_user.user

    respond_to do |format|
      format.html { redirect_to(@user) }
      format.xml  { head :ok }
    end
  end
end

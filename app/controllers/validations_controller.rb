class ValidationsController < ApplicationController
  # GET /validations
  # GET /validations.xml
  def index
    @validations = Validation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @validations }
    end
  end

  # GET /validations/1
  # GET /validations/1.xml
  def show
    @validation = Validation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @validation }
    end
  end

  # GET /validations/new
  # GET /validations/new.xml
  def new
    @validation = Validation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @validation }
    end
  end

  # GET /validations/1/edit
  def edit
    @validation = Validation.find(params[:id])
  end

  # POST /validations
  # POST /validations.xml
  def create
    @validation = Validation.new(params[:validation])

    respond_to do |format|
      if @validation.save
        flash[:notice] = 'Validation was successfully created.'
        format.html { redirect_to(@validation) }
        format.xml  { render :xml => @validation, :status => :created, :location => @validation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @validation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /validations/1
  # PUT /validations/1.xml
  def update
    @validation = Validation.find(params[:id])

    respond_to do |format|
      if @validation.update_attributes(params[:validation])
        flash[:notice] = 'Validation was successfully updated.'
        format.html { redirect_to(@validation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @validation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /validations/1
  # DELETE /validations/1.xml
  def destroy
    @validation = Validation.find(params[:id])
    @validation.destroy

    respond_to do |format|
      format.html { redirect_to(validations_url) }
      format.xml  { head :ok }
    end
  end
end

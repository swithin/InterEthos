class UsersTeamsController < ApplicationController
  # GET /users_teams
  # GET /users_teams.xml
  def index
    @users_teams = UsersTeam.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_teams }
    end
  end

  # GET /users_teams/1
  # GET /users_teams/1.xml
  def show
    @users_team = UsersTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users_team }
    end
  end

  # GET /users_teams/new
  # GET /users_teams/new.xml
  def new
    @users_team = UsersTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_team }
    end
  end

  # GET /users_teams/1/edit
  def edit
    @users_team = UsersTeam.find(params[:id])
  end

  # POST /users_teams
  # POST /users_teams.xml
  def create
    @users_team = UsersTeam.new(params[:users_team])

    respond_to do |format|
      if @users_team.save
        flash[:notice] = 'UsersTeam was successfully created.'
        format.html { redirect_to(@users_team) }
        format.xml  { render :xml => @users_team, :status => :created, :location => @users_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @users_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users_teams/1
  # PUT /users_teams/1.xml
  def update
    @users_team = UsersTeam.find(params[:id])

    respond_to do |format|
      if @users_team.update_attributes(params[:users_team])
        flash[:notice] = 'UsersTeam was successfully updated.'
        format.html { redirect_to(@users_team) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @users_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users_teams/1
  # DELETE /users_teams/1.xml
  def destroy
    @users_team = UsersTeam.find(params[:id])
    @users_team.destroy

    respond_to do |format|
      format.html { redirect_to(users_teams_url) }
      format.xml  { head :ok }
    end
  end
end

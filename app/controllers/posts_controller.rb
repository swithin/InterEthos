class PostsController < ApplicationController
  #  filter_resource_access # :nested_in => :collections_users
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all
  #BEG ADD
    session[:current_location] = posts_path
  #END ADD
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
  #BEG ADD
    session[:current_location] = posts_path
  #END ADD
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
      #BEG ADD
    @collection_id = params[:collection_id].to_i
    @category_id = params[:category_id].to_i
    session[:_location] = posts_path
  #END ADD
    
    #BEG ADD
    # @top = Topic.find(:all)
    #@top will store all the values of the topics table.
    #The plan is to access them by @top.topic_name
    #END ADD

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end
    #BEG ADD
    # @top = Topic.find(:all)
    #@top will store all the values of the topics table.
    #The plan is to access them by @top.topic_name
    #END ADD
    
  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    
    #BEG ADD
    # @post.topic_id  = (params[category])
    #It stores the value retreived from the select box of available categories
    #END ADD
    
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    
    #BEG ADD
    # @post.topic_id  = (params[category])
    #It stores the value retreived from the select box of available categories
    #END ADD
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end

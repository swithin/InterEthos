class PostsController < ApplicationController
  filter_resource_access
  
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
    @collection = Collection.find_all_by_id(@post.collection_id)
    @taxonomy = Taxonomy.find_all_by_id(@post.taxonomy_id)
    @category = Category.find_all_by_id(@post.category_id)
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
    @collection = Collection.find_all_by_id(params[:collection_id])
    @taxonomy = Taxonomy.find_all_by_id(params[:taxonomy_id])
    @category = Category.find_all_by_id(params[:category_id])
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
    @collection = Collection.find_all_by_id(@post.collection_id)
    @taxonomy = Taxonomy.find_all_by_id(@post.taxonomy_id)
    @category = Category.find_all_by_id(@post.category_id)
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
    @collection = Collection.find_all_by_id(@post.collection_id)
    @taxonomy = Taxonomy.find_all_by_id(@post.taxonomy_id)
    @category = Category.find_all_by_id(@post.category_id)
    
    #BEG ADD
    # @post.topic_id  = (params[category])
    #It stores the value retreived from the select box of available categories
    #END ADD
    
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        PostMailer::deliver_post_notification(@current_user,@post)
        if !@post.collection_id.nil?
          format.html { redirect_to(Collection.find_all_by_id(@post.collection_id))}
        elsif !@post.taxonomy_id.nil?
          format.html { redirect_to(Taxonomy.find_all_by_id(@post.taxonomy_id))}
        elsif !@post.category_id.nil?
          format.html { redirect_to(Category.find_all_by_id(@post.category_id))}
        else
          format.html { redirect_to(:controller => :welcome)}
        end
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

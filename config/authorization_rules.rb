authorization do
  # IMPORTANT: In order to run "rake db:migrate" you have to momentarily change 
    # ":to => :read" to ":to => [:manage, :create]", in EVERY place it appears below, 
	# for the ":guest" role. 
    # Then don't forget to change it back afterwards, or your permissions will be 
	# wide open for non-logged in users!

  # =========
  # G U E S T
  role :guest do
    # add permissions for guests here, e.g.
    has_permission_on :collections, :to => :read do
      if_attribute :status => "Active"
    end

    has_permission_on :ontologies, :to => :read do
      if_attribute :privacy => "Public"
    end

   has_permission_on [:categories], :to => :read

   has_permission_on [:users], :to => :create # needed so they can create a login.
   
   # has_permission_on [:categories, :category_collections, :collection_users, :languages, :relationships, :teams, :users, :validations], :to => :read
  end
  
  # =========
  # O W N E R
  role :owner do
    # Owners inherit all the permissions of Guests.
	includes :guest
    
	# ---------------------
	# C O L L E C T I O N S
	# Owners can "create" any new collection that they wish.
      has_permission_on :collections, :to => :create do
      end
	
	# Owners can only "manage" the collections that they own.
	  has_permission_on [:collections, :collection_users] do
		to :manage
		if_attribute :user_id => is {user.id}
		# | :collection_users => is {user.collection_users}
	  end
	
	# Owners can only "manage" the collection_users for which they own the collection.
	  has_permission_on :collection_users, :to => :manage do
		if_permitted_to :manage, :collection
	  end
	  
   has_permission_on :category_collections, :to => :manage do
		if_permitted_to :manage, :collection
	end
		
   has_permission_on :category_collections, :to => :create
	
	# -------------------
	# O N T O L O G I E S
	# Owners can "create" any new ontology that they wish.
      has_permission_on :ontologies, :to => :create do
      end
	
	# Owners can only "manage" the ontologies that they own.
	  has_permission_on [:ontologies, :ontology_users] do
		to :manage
		if_attribute :user_id => is {user.id}
		# | :ontology_users => is {user.ontology_users}
	  end
	
	# Owners can only "manage" the ontology_users for which they own the ontology.
	  has_permission_on :ontology_users, :to => :manage do
		if_permitted_to :manage, :ontology
	  end
	
	# -------------------
	# C A T E G O R I E S
	# Owners can "create" any new category that they wish.
      has_permission_on :categories, :to => :create
	  
	# Owners can only "manage" the categories that they own.
	  has_permission_on :categories do
		to :manage
		if_attribute :user_id => is {user.id}
	  end
	
	# Owners can only "manage" the category_users for which they own the category.
	  # has_permission_on :category_users, :to => :manage do
		# if_permitted_to :manage, :category
	  # end
	  
	# ---------
	# T E A M S
	# Owners can "create" any new team that they wish.
      has_permission_on :teams, :to => :create
	  
	# Owners can only "manage" the teams that they own.
	  has_permission_on [:teams, :team_users] do
		to :manage
		if_attribute :user_id => is {user.id}
		# | :team_users => is {user.team_users}
	  end
	
	# Owners can only "manage" the team_users for which they own the team.
	  has_permission_on :team_users, :to => :manage do
		if_permitted_to :manage, :team
	  end
	  
  end
  
  # =========
  # A D M I N
  role :admin do
    # Admins inherit all the permissions of Owners.
	includes :guest
   has_permission_on [:categories, :collections, :category_collections, :collection_users, :languages, :ontologies, :ontologies_users, :relationships, :teams, :teams_users, :users, :validations], :to => [:manage, :create]

   has_permission_on :ontologies do 
   		to :translate
		if_attribute :status => "Locked"
    end

   # Josh could not get the following working... 
       # documentation is at http://github.com/stffn/declarative_authorization
   # uncomment the following "has_permission_on" line, and 
       #then go to "http://localhost:3000/authorization_rules"
   # has_permission_on :authorization_rules, :to => :read
  end

end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :read, :includes => [:index, :show, :tree]
  privilege :update, :includes => [:edit, :update]
  privilege :delete, :includes => :destroy
  privilege :manage, :includes => [:read, :update, :delete]
  
  privilege :create, :includes => [:new, :create]
  privilege :translate, :includes => [:new, :create]
end
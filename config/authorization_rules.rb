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
      if_attribute :status => "Active",
	:privacy => "Public"
    end

    has_permission_on :taxonomies, :to => :read do
      if_attribute :privacy => "Public"
    end
    # PLEASE LEAVE THIS - Even though "Ontologies" have been renamed "Taxonomies" this is still
      #needed for the dataload of Ontology data on full migrations for GitHub repository installations
    has_permission_on :ontologies, :to => [:manage, :create] do
      if_attribute :privacy => "Public"
    end

   has_permission_on [:categories], :to => :read do
      if_attribute :user_id => is {1}  # Production user_id is "1"
      if_attribute :user_id => is {24} # Dev SQLite databases use "24"
   end

   has_permission_on :posts, :to => :read
   
   # allow anonymous 'user' to create an account... :create
   # allow anonymous 'user' 'read-only' actions... :read
   # IMPORTANT: This is required when creating a new account so the
     # "activation_code" to be sent out in the confirmation email
     # can be read from the newly created database record.
   # ACTUALLY the preceding ":read" may not be needed... please test
   has_permission_on :users, :to => [:create, :read, :activate]
   
   # 2010/08/12 New... but Josh does not understand it...
   has_permission_on :authorization_rules, :to => :read
   has_permission_on :authorization_usages, :to => :read
      
   # Guests can "translate" the categories for which they can "internationalize" the taxonomy.
   has_permission_on :categories, :to => :translate do
      if_attribute :taxonomy_id => 0 # ... which of course will never happen, as we don't want "guests" translating things.
     # JSS could not get the following working.
     # if_permitted_to :internationalize, :taxonomy #... which will never happen, as stated above.
   end
  end
  
  # =========
  # O W N E R
  role :owner do
    # Owners inherit all the permissions of Guests.
        includes :guest
        
    # ---------------------
    # C O L L E C T I O N S
        # Owners can "create" any new collection that they wish.
        has_permission_on [:collections, :category_collections], :to => [:create]
        
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
        # Owners can "create" any new taxonomy that they wish.
        has_permission_on :taxonomies, :to => :create
        
        # Owners can only "manage" the taxonomies that they own.
        has_permission_on [:taxonomies, :taxonomy_users] do
          to :manage
          if_attribute :user_id => is {user.id}
        end
        has_permission_on [:taxonomies] do
          to :read
          if_attribute :privacy => is {"Public"}
        end
        
        # Owners can only "internationalize" the taxonomies that they own, and that have "Status = Locked".
	has_permission_on :taxonomies do
	  to :internationalize
	  if_attribute :user_id => is {user.id},
	    :status => "Locked"
	end
	
        # Owners can only "manage" the taxonomy_users for which they own the taxonomy.
        has_permission_on :taxonomy_users, :to => :manage do
          if_permitted_to :manage, :taxonomy
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
        
        # Owners can "read" the categories for which they can "read" the taxonomy.
        has_permission_on :categories, :to => :read do
          if_permitted_to :read, :taxonomy
        end
        
        # Owners can "translate" the categories for which they can "internationalize" the taxonomy.
        has_permission_on :categories, :to => :translate do
          if_permitted_to :internationalize, :taxonomy
        end
        
    # ---------
    # P O S T S
        # Owners can "create" any new post that they wish.
        has_permission_on [:posts], :to => [:create]
        
    # -----------
    # T O P I C S
        # Owners can "read" all topics.
        has_permission_on [:topics], :to => [:read]
        
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
          
    # ---------
    # U S E R S
        # Owners can "manage" their own profile.
        has_permission_on [:users] do
          to :manage
          if_attribute :id => is {user.id}
        end
          
  end
  
  # =========
  # A D M I N
  role :admin do
    # Admins inherit all the permissions of Owners.
        includes :guest
        
        has_permission_on [:collections, :category_collections, :collection_users, :languages, :posts, :taxonomies_users, :relationships, :teams, :teams_users, :topics, :users, :validations], :to => [:manage, :create]
        has_permission_on [:taxonomies], :to => [:manage, :create, :internationalize]
        has_permission_on [:categories], :to => [:manage, :create, :translate]

        has_permission_on :taxonomies do 
          to :internationalize
          if_attribute :status => "Locked"
        end
  end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :read, :includes => [:index, :show, :tree]
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
  privilege :manage, :includes => [:read, :update, :delete]
  
  privilege :create, :includes => :new
  privilege :internationalize, :includes => [:create]
  privilege :translate, :includes => [:create]
  privilege :activate, :includes => [:read, :update, :create]
end
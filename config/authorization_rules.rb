authorization do
  role :admin do
   has_permission_on [:categories, :collections, :collections_ontologies, :languages, :ontologies, :relationships, :teams, :users, :validations], :to => :manage
  end

  role :guest do
    # add permissions for guests here, e.g.
    # has_permission_on :collections, :to => :read
   has_permission_on [:categories, :collections, :collections_ontologies, :languages, :ontologies, :relationships, :teams, :users, :validations], :to => :read
  end
  
  role :owner do
    # add permissions for owners here, e.g.
   has_permission_on [:collections, :ontologies], :to => [:read, :new, :create]
   has_permission_on [:collections, :ontologies], :to => [:update, :delete] # do
      # if_attribute :user => is { user }
   # end
   has_permission_on [:categories, :collections_ontologies, :relationships], :to => :manage
  end
  
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete, :tree]
  privilege :create, :includes => :new
  privilege :read, :includes => [:index, :show, :tree]
  privilege :update, :includes => [:edit, :update]
  privilege :delete, :includes => :destroy
end
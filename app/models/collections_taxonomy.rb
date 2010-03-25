class CollectionsTaxonomy < ActiveRecord::Base
  belongs_to :collection
  belongs_to :taxonomy
end

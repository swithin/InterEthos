class Relationship < ActiveRecord::Base
  belongs_to :category
  belongs_to :synonym, :class_name => "Category"
  attr_accessible :category_id, :synonym_id
end

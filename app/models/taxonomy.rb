class Taxonomy < ActiveRecord::Base
  has_many :categories

  belongs_to :language

  has_many :internationalizations, :source => :taxonomy, :order => ':name'
      #, :foreign_key => 'internationalization_id', :class_name => "Internationalizations", 

  has_many :taxonomy_users
	  has_many :users, :through => :taxonomy_users

  using_access_control

  validates_presence_of :language_id
end
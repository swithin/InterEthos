class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :collection
  belongs_to :category
end

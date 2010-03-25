class TaxonomiesUser < ActiveRecord::Base
  belongs_to :taxonomy
  belongs_to :user
end

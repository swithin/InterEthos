class User < ActiveRecord::Base
  belongs_to :validation
  has_and_belongs_to_many :teams
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_length_of :first_name, :maximum => 30
  validates_length_of :last_name, :maximum => 30
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def <=>(other)
    self.name <=> other.name
  end
end

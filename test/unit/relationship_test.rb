require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Relationship.new.valid?
  end
end

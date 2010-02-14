require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  def test_create_invalid
    Relationship.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Relationship.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    relationship = Relationship.first
    delete :destroy, :id => relationship
    assert_redirected_to root_url
    assert !Relationship.exists?(relationship.id)
  end
end

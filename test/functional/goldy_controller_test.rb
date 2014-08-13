require 'test_helper'

class GoldyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get –no-controller-specs" do
    get :–no-controller-specs
    assert_response :success
  end

end

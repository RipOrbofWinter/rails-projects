require 'test_helper'

class CombatControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get combat_test_url
    assert_response :success
  end

end

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get setup" do
    get pages_setup_url
    assert_response :success
  end

end

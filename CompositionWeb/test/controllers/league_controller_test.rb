require 'test_helper'

class LeagueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get league_index_url
    assert_response :success
  end

  test "should get showWinrate" do
    get league_showWinrate_url
    assert_response :success
  end

  test "should get showWinrateTeam" do
    get league_showWinrateTeam_url
    assert_response :success
  end

end

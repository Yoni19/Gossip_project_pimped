require 'test_helper'

class GossipsControllerTest < ActionDispatch::IntegrationTest
  test "should get team" do
    get gossips_team_url
    assert_response :success
  end

  test "should get contact" do
    get gossips_contact_url
    assert_response :success
  end

end

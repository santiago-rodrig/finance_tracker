require 'test_helper'

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get stocks_search_url
    assert_response :success
  end

end

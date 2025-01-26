require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get search_transactions_suggestions_url
    assert_response :success
  end
end

require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in(:anderson)
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should destroy transaction" do
    assert_difference("Transaction.count", -1) do
      delete transaction_url(@transaction, format: :turbo_stream)
    end

    assert_turbo_stream action: "remove", count: 1
  end
end

require "test_helper"

class Search::Transactions::SuggestionsControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in(:anderson) }

  test "returns no content for no transactions found" do
    get search_transactions_suggestions_url, params: { q: "Bing" }
    assert_response :no_content
  end

  test "returns a single transaction when there are multiple with the same name" do
    _transaction_1 = expense.create!(title: "bada bing", value: 1, account: accounts(:santander), category: categories(:groceries))
    transaction_2 = expense.create!(title: "bada bing", value: 2, account: accounts(:wallet), category: categories(:groceries))

    get search_transactions_suggestions_url(format: :turbo_stream), params: { q: "bing" }

    assert_response :ok
    assert_select "li[role='option']", count: 1
    assert_select "li[role='option'][data-id='#{transaction_2.id}']"
  end

  test "returns multiple records limited to two when there transactions matching with different names" do
    _transaction_1 = Expense.create!(
      title: "bada bing",
      value: 1,
      account: accounts(:santander),
      category: categories(:groceries)
    )
    transaction_2 = Expense.create!(
      title: "bada bong",
      value: 2,
      account: accounts(:wallet),
      category: categories(:groceries)
    )
    transaction_3 = Expense.create!(
      title: "bada ding",
      value: 2,
      account: accounts(:wallet),
      category: categories(:groceries)
    )

    get search_transactions_suggestions_url(format: :turbo_stream), params: { q: "bada" }

    assert_response :ok
    assert_select "li[role='option']", count: 2
    assert_select "li[role='option'][data-id='#{transaction_3.id}']"
    assert_select "li[role='option'][data-id='#{transaction_2.id}']"
  end

  test "when searching with white spaces" do
    transaction_1 = Expense.create!(
      title: "bada bing",
      value: 1,
      account: accounts(:santander),
      category: categories(:groceries)
    )

    get(
      search_transactions_suggestions_url(format: :turbo_stream),
      params: { q: URI.encode_uri_component("bada ") }
    )

    assert_response :ok
    assert_select "li[role='option']", count: 1
    assert_select "li[role='option'][data-id='#{transaction_1.id}']"
  end
end

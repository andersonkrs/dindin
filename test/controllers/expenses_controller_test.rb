require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in(:anderson)
    @expense = transactions(:one)
  end

  test "should get new expense form" do
    get new_expense_url
    assert_response :success
    assert_select "h1", "New expense"
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          title: "Groceries",
          value: "15.99",
          due_on: Time.zone.today,
          category_id: categories(:groceries).id,
          account_id: accounts(:wallet).id,
          paid: "1"
        },
        format: :turbo_stream
      }
    end

    assert_response :success
    assert_match "Expense created", response.body
    assert_turbo_stream
  end

  test "should not create invalid expense" do
    assert_no_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          title: "", # Invalid: empty title
          value: "15.99",
          due_on: Time.zone.today,
          category_id: categories(:groceries).id,
          account_id: accounts(:wallet).id
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "div", /Title can't be blank/
  end

  test "should get edit expense form" do
    get edit_expense_url(@expense)
    assert_response :success
    assert_select "h1", "Edit expense"
  end

  test "should update expense" do
    patch expense_url(@expense), params: {
      expense: {
        title: "Updated Groceries",
        value: "25.99",
        due_on: Time.zone.today,
        category_id: categories(:groceries).id,
        account_id: accounts(:wallet).id,
        paid: "0"
      },
      format: :turbo_stream
    }

    assert_response :success
    assert_match "Expense updated", response.body
    assert_turbo_stream key: value

    @expense.reload
    assert_equal "Updated Groceries", @expense.title
    assert_equal 2599, @expense.value_cents
    assert_nil @expense.paid_at
  end

  test "should not update expense with invalid data" do
    patch expense_url(@expense), params: {
      expense: {
        title: "", # Invalid: empty title
        value: "25.99"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should mark expense as paid when paid checkbox is checked" do
    patch expense_url(@expense), params: {
      expense: {
        title: @expense.title,
        value: @expense.value.to_s,
        due_on: @expense.due_on,
        category_id: @expense.category_id,
        account_id: @expense.account_id,
        paid: "1"
      },
      format: :turbo_stream
    }

    @expense.reload
    assert_not_nil @expense.paid_at
    assert_equal Time.zone.today, @expense.paid_at.to_date
  end

  test "should mark expense as unpaid when paid checkbox is unchecked" do
    # First ensure it's paid
    @expense.update(paid_at: Time.zone.today)
    assert_not_nil @expense.paid_at

    # Then unmark it
    patch expense_url(@expense), params: {
      expense: {
        title: @expense.title,
        value: @expense.value.to_s,
        due_on: @expense.due_on,
        category_id: @expense.category_id,
        account_id: @expense.account_id,
        paid: "0"
      },
      format: :turbo_stream
    }

    @expense.reload
    assert_nil @expense.paid_at
  end
end


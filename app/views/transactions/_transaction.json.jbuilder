json.extract! transaction, :id, :title, :due_on, :paid_at, :category_id, :account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

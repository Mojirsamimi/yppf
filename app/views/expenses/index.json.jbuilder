json.array!(@expenses) do |expense|
  json.extract! expense, :id, :expenseid, :user_id, :expensetype, :frequency, :projvalue, :actvalue, :percent, :month, :year
  json.url expense_url(expense, format: :json)
end

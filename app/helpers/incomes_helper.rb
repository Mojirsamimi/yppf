module IncomesHelper
  def get_incomes(year,month)
    Income.where(user_id: current_user.id,year: year,month: month).map { |c| [c.income+"($#{c.value.to_f})", c.value.to_f] }
    
  end
  
end

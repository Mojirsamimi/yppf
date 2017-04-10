module ExpensesHelper
  def get_progress_type i
    if i > 75
      "progress-bar-danger"
    elsif i >50
      "progress-bar-warning"
    else
      "progress-bar-success"
    end
  end


  def get_total_expenditure_message(month, year)
    exp=Expense.where(user_id: current_user.id,month: month,year: year)
    if exp.size == 0
      return "You have not uploaded sufficient data to make calculations for this month"
    else
      projected = projvalue_sum(month, year)
      if projected == 0
        return "You have not uploaded sufficient data to make calculations for this month"
      else
        return "Total Expenditure - #{get_total_expenditure(month, year)}% of monthly budget used"
      end
    end
  end
  
  def get_sumProj(category)
    Expense.where(user_id: current_user.id,month: Date.today.month,year: Date.today.year,expense_category_id: category).sum(:projvalue)
  end

  def get_total_expenditure(month,year)
      projected = projvalue_sum(month, year)
      if projected == 0
        return 0
      end
      actual = actvalue_sum(month, year)
      return ((actual/projected) * 100).to_i 
  end
  
  def projvalue_sum(month, year)
   Expense.where(user_id: current_user.id,month: month,year: year).sum(:projvalue)
  end
 def actvalue_sum(month, year)
    Expense.where(user_id: current_user.id,month: month,year: year).sum(:actvalue)
 end
  def get_actvalue(month, year)
   
      return actvalue_sum(month,year)
    
  end


  def get_projvalue(month, year)
    
      return projvalue_sum(month,year)
    
  end

  def get_percentage(category)
    sumAct = get_sumAct(category)
    sumProj = get_sumProj(category)
    if sumProj > 0
      return sumAct/sumProj
    else
      return 0
    end
  end

  def get_sumAct(category)
    Expense.where(user_id: current_user.id,month: Date.today.month,year: Date.today.year,expense_category_id: category).sum(:actvalue)
    
  end

  
end

module BudgetsHelper
  
  def initialize_expenses
    
    @expenses = Expense.where(user_id: current_user.id).where(month:Date.today.month).where(year:Date.today.year)
    expense_cat_id=@expenses.select(:expense_category_id).distinct
    @expense_categories = ExpenseCategory.where(id: expense_cat_id).order(exp_name: :asc)
    
  end
  def initialize_incomes
    @incomes = Income.where(user_id: current_user.id).where(month:Date.today.month).where(year:Date.today.year)
  end
  
  

  def expenses_by_category(category_id)

    Expense.where(user_id: current_user.id,month:Date.today.month,year:Date.today.year,expense_category_id: category_id).order(expensename: :asc)

  end
  def expenses_size_by_category(category_id)

    Expense.where(user_id: current_user.id,month:Date.today.month,year:Date.today.year,expense_category_id: category_id).size

  end
  
  end

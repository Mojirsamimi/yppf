class ExpenseDetail < ActiveRecord::Base
  belongs_to :expense
  after_save :update_expense_actvalue
  
  def update_expense_actvalue
    exp=self.expense
    exp.actvalue=exp.actvalue+self.expdet_value
    exp.save
  end
end

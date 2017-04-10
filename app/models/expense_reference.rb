class ExpenseReference < ActiveRecord::Base
  has_many :expenses, dependent: :destroy
  belongs_to :user
  validates :ref_name, presence: true
  validates :ref_value, presence: true
  validates :expense_category_id, presence: true
  validates :ref_month, presence: true
  validates :ref_year, presence: true
  validates :ref_type, presence: true
  after_save :create_expense
  #before_destroy :exp_ref_with_child_cannot_be_destroyed
  
  def expense_category_name
  ExpenseCategory.find(expense_category_id).exp_name
  end
  
  def create_expense
    #if self.ref_year==Date.today.year && self.ref_month==Date.today.month
      exp=Expense.create(expensename: self.ref_name,expense_reference_id: self.id,user_id: self.user_id, expense_category_id: self.expense_category_id, expensetype: 0, frequency: "biweekly", projvalue: self.ref_value, actvalue: 0, percent: 0, month: self.ref_month, year: self.ref_year)
      exp.save
   # end
  end
 
  #def exp_ref_with_child_cannot_be_destroyed
   # if self.expenses.size>0
    #  errors.add(:base,"This expense can not be deleted! There are records associated with this expense!")
    #end
  #end
end

class ExpenseDetailsController < ApplicationController

  before_action :authenticate_user!

  def new

    @expense_detail = ExpenseDetail.new
    respond_to do |format|
      format.js
    end
  end
  def create
    @exp_detail = ExpenseDetail.new(expense_detail_params)
    @exp_detail.expense_id=params["expense_id"]
    @exp_detail.user_id=current_user.id
    @exp=@exp_detail.expense
    respond_to do |format|
      if @exp_detail.save
        @category_act_value=0

        format.js

      end
    end
  end

  private
  def expense_detail_params

    
    params.require(:expense_detail).permit(:user_id, :expdet_date, :expdet_value, :expense_id,:expdet_description)
    end
end

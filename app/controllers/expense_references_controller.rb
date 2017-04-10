class ExpenseReferencesController < ApplicationController
  before_action :set_expense_ref, only: [:destroy,:edit,:update]
before_action :authenticate_user!
 helper_method :expense_category_options
 protect_from_forgery with: :null_session


  def index
    @expense_refs_once=ExpenseReference.where(user_id: current_user.id,ref_type: 1).order(created_at: :desc)
    @expense_refs_every=ExpenseReference.where(user_id: current_user.id,ref_type: 2).order(created_at: :desc)
    @destroy_warning_msg="All history associated with this expense will be removed. Are you sure?"
  end
  def show

  end

  def edit

  end

  def update
    respond_to do |format|
      if @expense_ref.update(expense_reference_params_update)
        format.html { redirect_to expense_references_path, notice: 'Expense was successfully updated.' }

      else
        format.html { render :edit }
      end
    end
  end

  def new
    @expense_ref = ExpenseReference.new
  end

  def allinonenew
    @expense_ref = ExpenseReference.new
    respond_to do |format|
      format.js
    end
  end

  def justgeneral
    @expense_ref = ExpenseReference.new
    respond_to do |format|
      format.js
    end
  end
def createrecurrent
  @expense_ref = ExpenseReference.new(expense_reference_params)
    @expense_ref.user_id=current_user.id
    @expense_ref.ref_status=1
    @expense_ref.ref_type=2
    if @expense_ref.save

        respond_to do |format|
      format.html { redirect_to expense_references_url, notice: 'New recurrent expense created successfully.' }
      end

      end
end
  def create
    @expense_ref = ExpenseReference.new(expense_reference_params)
    @expense_ref.user_id=current_user.id
    @expense_ref.ref_status=1

    respond_to do |format|
      if @expense_ref.save

        format.js

      end
    end
  end

  def destroy
    @expense_ref.destroy
    respond_to do |format|
      format.html { redirect_to expense_references_url, notice: 'Expense and all associated records were successfully removed.' }
      format.json { head :no_content }
    end
  end
  def expense_category_options
    ExpenseCategory.where("(user_id="+current_user.id.to_s+" or user_id is null) and exp_type=1").order(:exp_name).pluck(:exp_name,:id)
  end

  def newone

    @one_exp_ref = ExpenseReference.new
    respond_to do |format|
      format.js
    end
  end

  def createone
    @one_exp_ref = ExpenseReference.new(expense_reference_params)
    @one_exp_ref.user_id=current_user.id
    @one_exp_ref.ref_status=1 #active
    @one_exp_ref.ref_type=1 #once
    @one_exp_ref.ref_month=Date.today.month
    @one_exp_ref.ref_year=Date.today.year
    @is_new_category=Expense.where(user_id: @one_exp_ref.user_id,month:@one_exp_ref.ref_month,year:@one_exp_ref.ref_year,expense_category_id:@one_exp_ref.expense_category_id).size==0
    respond_to do |format|
      if @one_exp_ref.save

        format.js

      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_ref
      @expense_ref = ExpenseReference.find(params[:id])
    end

    def expense_reference_params_update
      params.require(:expense_reference).permit(:ref_name,:ref_value)
    end

    def expense_reference_params
      params.require(:expense_reference).permit(:ref_name,:expense_category_id,:ref_value,:ref_type,:ref_month, :ref_year)
    end

end

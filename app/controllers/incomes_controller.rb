class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!
  # GET /incomes
  # GET /incomes.json
  def index
    @incomes = Income.all
  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show
  end

  # GET /incomes/new
  def new
    @income = Income.new
    respond_to do |format|
      format.js
    end
  end

  # GET /incomes/1/edit
  def edit
  end

  # POST /incomes
  # POST /incomes.json
  def create
    @income = Income.new(income_params)
    if user_signed_in?
      @income.user_id = current_user.id
    end
    @income.month=Date.today.month
    @income.year=Date.today.year
    @income.day_rec=Date.today.day
@income_chart_data=[['IE',56.33],['Chrome',24.03],['Safari',4.77],['Opera',0.91],{name: 'Proprietary or Undetectable',y: 0.2,dataLabels: {enabled: false}}]
    respond_to do |format|
      if @income.save
        format.js
      end
    end
  end

  # PATCH/PUT /incomes/1
  # PATCH/PUT /incomes/1.json
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def income_params
      params.require(:income).permit(:user_id, :income, :incometype, :value, :frequency, :day_rec, :month, :year)
    end
end

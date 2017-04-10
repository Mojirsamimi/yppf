class TrendController < ApplicationController
  before_action :authenticate_user!

  def new

    #queries and information for the trend line chart
    @x = Expense.where(year: Date.today.year).where(user_id: current_user.id).group(:expense_category_id).order('sum_projvalue desc').sum(:projvalue)
    @total = 0
    @x.each { |y|
      @total = @total + y[1]
    }

    @chartarray = []
    x = Expense.select(:year, :month, 'sum_actvalue').group(:year, :month).order(:year, :month).sum(:actvalue)
    x.each {|y|
      @chartarray.append([[y[0][0].to_i, y[0][1].to_i], y[1].to_i])
    }


    puts @chartarray.to_s

    # information for search category bar chart
    x2 = Expense.select(:expense_category_id).where(user_id: current_user.id).where(year: Date.today.year).group(:expense_category_id)
    @categories = []
    x2.each { |y| @categories.append([y.expense_category_name, y.expense_category_id])}


    # attempting to make graph appear before search, but didn't work
    if !@categories.empty?
    selected_category = @categories[0][1]
    @category_name2 = ExpenseCategory.find(selected_category).exp_name
    query = Expense.where(user_id: current_user.id).where(expense_category_id: selected_category).where(year: Date.today.year).group(:month).order(:month).sum(:actvalue)

    @months2 = []
    @values2 = []
    query.each { |y|
      # months
      @months2.append(MONTHS[y[0]])
      # actual value
      @values2.append(y[1].to_f)
    }
    end

  end

  def barchart

    @months2=[]

    selected_category = params[:categoryselect]
    @category_name = ExpenseCategory.find(selected_category).exp_name
    query = Expense.where(user_id: current_user.id).where(expense_category_id: selected_category).where(year: Date.today.year).group(:month).order(:month).sum(:actvalue)

    @months = []
    @values = []
    query.each { |y|
      # months
      @months.append(MONTHS[y[0]])
      # actual value
      @values.append(y[1].to_f)
    }

    respond_to do |format|
      format.js
    end

  end

  MONTHS = [0, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

end

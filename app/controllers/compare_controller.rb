class CompareController < ApplicationController
  before_action :authenticate_user!

  def new
    array = Expense.select(:month, :year).where(user_id: current_user.id).group(:month, :year).order(:month, :year)
    @months = []
    array.each { |a|
      e = [MONTHS[a.month]+' '+a.year.to_s, a.month]
      @months.append(e)
    }
    @compare = ""
  end

  def create
    # the months selected by the user
    @month1select = params[:month1select]
    @month2select = params[:month2select]

    # queries for initial pie chart and bar chart with expenses for each month
    @month1expenses = Expense.where(user_id: current_user.id).where(month: @month1select.to_i).group(:expense_category_id).sum(:actvalue)
    @series1 = []
    @month1expenses.each{ |m|
      category_id = m[0]
      query = ExpenseCategory.find(category_id)
      x = [query.exp_name.to_s, m[1].to_f]
      @series1.append(x)
    }

    @month2expenses = Expense.where(user_id: current_user.id).where(month: @month2select.to_i).group(:expense_category_id).sum(:actvalue)
    @series2 = []
    @month2expenses.each{ |m|
      category_id = m[0]
      query = ExpenseCategory.find(category_id)
      x = [query.exp_name.to_s, m[1].to_f]
      @series2.append(x)
    }


    # Bar chart
    # all the expense types for both months
    alltypes = Expense.where(:month => [@month1select, @month2select]).group(:expense_category_id, :id)
    @selectedtypes = []
    # values for these expenses for each month
    @month1values = []
    @month2values = []

    alltypes.each { |t|
      # adding expense categories to global array
      x = t.expense_category_id
      y = ExpenseCategory.find(x)

      @selectedtypes.append(y.exp_name)

      # queries to find values for expense type x
      month1query = Expense.where(user_id: current_user.id).where(month: @month1select.to_i).where(expense_category_id: x)
      month2query = Expense.where(user_id: current_user.id).where(month: @month2select.to_i).where(expense_category_id: x)

      # if no expense type x for month 1
      if month1query.empty?
        @month1values.append(0)
      else
        month1query.each { |a|
          # value of expense type x in month1
          @month1values.append(a.actvalue.to_f)
        }
      end

      # if no expense type x for month 2
      if month2query.empty?
        @month2values.append(0)
      else
        month2query.each { |a|
          # value of expense type x in month2
          @month2values.append(a.actvalue.to_f)
        }
      end

    }

    # month 1 and 2 in string (ex. January) instead of ints
    @month1name = MONTHS[@month1select.to_i]
    @month2name = MONTHS[@month2select.to_i]

    respond_to do |format|
      format.js
    end

  end

  MONTHS = [0, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']


end

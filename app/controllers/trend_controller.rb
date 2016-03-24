class TrendController < ApplicationController
  before_action :authenticate_user!

  def new
    # puts current_user.id
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
  end
end

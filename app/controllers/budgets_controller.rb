class BudgetsController < ApplicationController

  before_action :authenticate_user!
    include BudgetsHelper
   

  def display    
    
    initialize_incomes
    @get_month_year = "#{MONTHS[Date.today.month]} #{Date.today.year}"
    @get_day = "#{Date.today.day}"
    
    
  end

  

  MONTHS = [0, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

end

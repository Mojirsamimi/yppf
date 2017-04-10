class CalendarController < ApplicationController
  before_action :authenticate_user!

  def new
    @bills = Bill.all
  end

end

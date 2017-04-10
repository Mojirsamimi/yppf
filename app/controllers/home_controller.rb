class HomeController < ApplicationController
  def new
    if user_signed_in?
      redirect_to '/dashboard/new'
    end
  end
end

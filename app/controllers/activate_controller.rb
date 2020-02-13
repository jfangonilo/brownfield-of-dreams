class ActivateController < ApplicationController
  def create
    # require "pry"; binding.pry
    UserActivatorMailer.inform(current_user).deliver_now
  end

  def update
    require "pry"; binding.pry
  end
end

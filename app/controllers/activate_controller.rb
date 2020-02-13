class ActivateController < ApplicationController
  def create
    UserActivatorMailer.inform(current_user).deliver_now
  end
end

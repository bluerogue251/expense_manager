class DashboardController < ApplicationController
  delegate :number_with_precision, to: :view_context

  def show
    @dashboard = Dashboard.new(current_user)
  end

  def change_month
    month = Date.parse(params[:month])
    @dashboard = Dashboard.new(current_user, month)
  end

end

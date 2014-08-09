class DashboardController < ApplicationController
  delegate :number_with_precision, to: :view_context

  def show
    @dashboard = Dashboard.new(current_user)
  end

end

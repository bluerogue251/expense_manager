class ExchangeRatesController < ApplicationController
  def index
    @exchange_rate = ExchangeRate.new
    @exchange_rates = ExchangeRate.by_starts_on
  end

  def create
    @exchange_rate = ExchangeRate.new(exchange_rate_params)
    @exchange_rate.save
    render "create_or_update"
  end

  def destroy
    find_exchange_rate
    @exchange_rate.destroy!
  end

  private

  def find_exchange_rate
    @exchange_rate = ExchangeRate.find(params[:id])
  end

  def exchange_rate_params
    params.require(:exchange_rate).permit(:anchor, :float, :rate, :starts_on, :ends_on)
  end
end

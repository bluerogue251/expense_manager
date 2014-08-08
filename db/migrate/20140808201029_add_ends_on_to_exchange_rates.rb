class AddEndsOnToExchangeRates < ActiveRecord::Migration
  def change
    add_column :exchange_rates, :ends_on, :date, null: false
  end
end

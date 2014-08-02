class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.string :anchor, null: false
      t.string :float, null: false
      t.decimal :rate, null: false
      t.date :starts_on, null: false

      t.timestamps null: false
    end
  end
end

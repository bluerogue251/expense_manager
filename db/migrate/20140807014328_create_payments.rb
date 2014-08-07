class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.string :currency, null: false
      t.decimal :amount, null: false

      t.timestamps null: false
    end
  end
end

class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id, null: false
      t.date :date, null: false
      t.integer :category_id, null: false
      t.string :description, null: false
      t.string :currency, null: false
      t.decimal :amount, null: false
      t.string :status, null: false, default: "Pending"

      t.timestamps null: false
    end
  end
end

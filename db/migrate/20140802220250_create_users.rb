class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users  do |t|
      t.timestamps null: false
      t.string :name,  null: false
      t.string :email, null: false
      t.string :default_currency, null: false, default: "USD"
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128, null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_token, unique: true
  end

  def self.down
    drop_table :users
  end
end

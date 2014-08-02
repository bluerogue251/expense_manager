class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :user, :date, :category, :description, :currency, :amount, :status, presence: true
end

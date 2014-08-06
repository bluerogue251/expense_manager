class Expense < ActiveRecord::Base
  STATUSES = %w(Pending Approved Rejected)
  belongs_to :user
  belongs_to :category

  validates :user, :date, :category, :description, :amount, presence: true
  validates :status, inclusion: { in: STATUSES, allow_blank: false }
  validates :currency, inclusion: { in: ExchangeRate::CURRENCIES, allow_blank: false }
end

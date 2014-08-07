class Payment < ActiveRecord::Base
  belongs_to :user

  validates :user, :date, presence: true
  validates :currency, inclusion: { in: ExchangeRate::CURRENCIES }
  validates :amount, numericality: { greater_than: 0 }
end

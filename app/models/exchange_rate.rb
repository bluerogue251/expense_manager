class ExchangeRate < ActiveRecord::Base
  CURRENCIES = %w(USD CAD CNY HKD)
  validates :rate, :starts_on, presence: true
  validates :anchor, :float, inclusion: { in: CURRENCIES, allow_blank: false }
end

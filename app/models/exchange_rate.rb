class ExchangeRate < ActiveRecord::Base
  validates :anchor, :float, :rate, :starts_on, presence: true
end

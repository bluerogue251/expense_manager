class ExchangeRate < ActiveRecord::Base
  CURRENCIES = %w(USD CAD CNY HKD)
  validates :starts_on, :ends_on, presence: true
  validates :rate, numericality: { greater_than: 0 }
  validates :anchor, :float, inclusion: { in: CURRENCIES, allow_blank: false }

  validate :anchor_and_float_cannot_be_the_same
  scope :by_starts_on, -> { order(:starts_on) }

  private

  def anchor_and_float_cannot_be_the_same
    if anchor == float
      errors.add(:anchor, 'and float currencies cannot be the same')
    end
  end
end

class Expense < ActiveRecord::Base
  STATUSES = %w(Pending Approved Rejected)
  belongs_to :user
  belongs_to :category

  validates :user, :date, :category, :description, :amount, presence: true
  validates :status, inclusion: { in: STATUSES, allow_blank: false }
  validates :currency, inclusion: { in: ExchangeRate::CURRENCIES, allow_blank: false }

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true

  scope :rejected,  -> { where(status: "Rejected") }
  scope :pending,   -> { where(status: "Pending") }
  scope :approved,  -> { where(status: "Approved") }

  def self.by_category_in(currency)
    join_exchange_rate
    .joins(:category)
    .select("categories.name, '#{currency}' as sum_currency, sum(amount) as sum_amount")
    .group("expenses.category_id")
  end

  def self.join_exchange_rate
    joins("LEFT OUTER JOIN exchange_rates ON expenses.currency = exchange_rates.anchor AND expenses.date >= exchange_rates.starts_on ORDER BY exchange_rates.starts_on DESC LIMIT 1")
  end

  def approved?
    status == "Approved"
  end

  def rejected?
    status == "Rejected"
  end

  def pending?
    status == "Pending"
  end
end

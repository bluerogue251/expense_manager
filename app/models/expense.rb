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
    joins_exchange_rates_and_categories(currency)
    .select("categories.name, '#{currency}'::text as sum_currency, sum(expenses.amount * exchange_rates.rate) as sum_amount")
    .group("expenses.category_id, categories.name")
  end

  def self.joins_exchange_rates_and_categories(currency)
    joins(:category)
    .joins("LEFT OUTER JOIN exchange_rates
            ON exchange_rates.anchor = expenses.currency
            AND exchange_rates.float = '#{currency}'
            AND expenses.date BETWEEN exchange_rates.starts_on AND exchange_rates.ends_on")
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

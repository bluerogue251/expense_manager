class Expense < ActiveRecord::Base
  STATUSES = %w(Pending Approved Rejected)
  belongs_to :user
  belongs_to :category
  has_one :expense_department_and_job_title

  validates :user, :date, :category, :description, :amount, presence: true
  validates :status, inclusion: { in: STATUSES, allow_blank: false }
  validates :currency, inclusion: { in: ExchangeRate::CURRENCIES, allow_blank: false }

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :department_name, :job_title_name, to: :expense_department_and_job_title, prefix: false, allow_nil: true

  scope :rejected,  -> { where(status: "Rejected") }
  scope :pending,   -> { where(status: "Pending") }
  scope :approved,  -> { where(status: "Approved") }
  scope :for_month, lambda { |month| where("to_char(date, 'YYYY-MM') = ?", month) }

  searchable do
    integer :user_id
    text :description
  end

  def self.sum_in(currency)
    joins_exchange_rates(currency)
    .sum("CASE WHEN expenses.currency = '#{currency}' THEN expenses.amount ELSE (expenses.amount * exchange_rates.rate) END")
  end

  def self.joins_exchange_rates(currency)
    joins("LEFT OUTER JOIN exchange_rates
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

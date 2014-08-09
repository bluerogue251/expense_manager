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
  scope :for_month, lambda { |month| where("to_char(date, 'YYYY-MM') = ?", month) }

  # def self.by_category_in(currency)
  #   joins_exchange_rates(currency)
  #   .joins(:category)
  #   .select("categories.name, '#{currency}'::text as sum_currency, sum(expenses.amount * exchange_rates.rate) as sum_amount")
  #   .group("expenses.category_id, categories.name")
  # end

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

  def self.with_department_and_job_title
    job_title_assignment_join
    .department_join
    .job_title_join
    .select("expenses.*, departments.name as department_name, job_titles.name as job_title_name")
  end

  def self.job_title_assignment_join
    joins("LEFT OUTER JOIN job_title_assignments
           ON expenses.user_id = job_title_assignments.user_id
           AND expenses.date BETWEEN job_title_assignments.starts_on AND job_title_assignments.ends_on")
  end

  def self.department_join
    joins("LEFT OUTER JOIN departments ON job_title_assignments.department_id = departments.id")
  end

  def self.job_title_join
    joins("LEFT OUTER JOIN job_titles ON job_title_assignments.job_title_id = job_titles.id")
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

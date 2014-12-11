class Expense < ActiveRecord::Base
  STATUSES = %w(Pending Approved Rejected)
  belongs_to :user
  belongs_to :category
  has_one :expense_job_title_assignment
  has_one :job_title_assignment, through: :expense_job_title_assignment, class_name: JobTitleAssignment

  validates :user, :date, :category, :description, :amount, presence: true
  validates :status, inclusion: { in: STATUSES, allow_blank: false }
  validates :currency, inclusion: { in: ExchangeRate::CURRENCIES, allow_blank: false }

  delegate :name, to: :category, prefix: true
  delegate :name, to: :user, prefix: true
  delegate :job_title, :department, to: :job_title_assignment, allow_nil: true
  delegate :name, to: :department, prefix: true, allow_nil: true
  delegate :name, to: :job_title, prefix: true, allow_nil: true

  scope :rejected,  -> { where(status: "Rejected") }
  scope :pending,   -> { where(status: "Pending") }
  scope :approved,  -> { where(status: "Approved") }
  scope :for_month, lambda { |month| where("to_char(date, 'YYYY-MM') = ?", month) }

  searchable do
    integer :user_id
    text    :user_name, :department_name, :job_title_name, :date, :category_name, :description, :currency, :amount, :status
    string  :s_user_name       do user_name       end
    string  :s_department_name do department_name end
    string  :s_job_title_name  do job_title_name  end
    date    :s_date            do date            end
    string  :s_category_name   do category_name   end
    string  :s_description     do description     end
    string  :s_currency        do currency        end
    double  :s_amount          do amount          end
    string  :s_status          do status          end
  end
  handle_asynchronously :solr_index

  # In theory, currency should not have to be sanitized because it comes from
  # the expenses.currency database column, which should have been validated
  # against a list of approved currencies. This method and the
  # self.joins_exchange_rates methods sanitize them anyways just in case
  def self.sum_in(currency)
    joins_exchange_rates(currency)
    .sum("CASE WHEN expenses.currency = #{sanitize(currency)} THEN expenses.amount ELSE (expenses.amount * exchange_rates.rate) END")
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

  private

  def self.joins_exchange_rates(currency)
    joins("LEFT OUTER JOIN exchange_rates
             ON exchange_rates.anchor = expenses.currency
             AND exchange_rates.float = #{sanitize(currency)}
             AND expenses.date BETWEEN exchange_rates.starts_on AND exchange_rates.ends_on")
  end
  private_class_method :joins_exchange_rates
end

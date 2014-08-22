class User < ActiveRecord::Base
  include Clearance::User
  include ReindexExpensesAfterSave

  validates :name, :email, presence: true
  validates :default_currency, inclusion: { in: ExchangeRate::CURRENCIES }

  has_many :expenses
  has_many :payments
  has_many :job_title_assignments
  has_many :job_titles, through: :job_title_assignments
  has_many :departments, through: :job_title_assignments

  accepts_nested_attributes_for :job_title_assignments, reject_if: :all_blank, allow_destroy: true

end

class User < ActiveRecord::Base
  include Clearance::User
  validates :name, :email, presence: true
  validates :default_currency, inclusion: { in: ExchangeRate::CURRENCIES }

  has_many :expenses
  has_many :payments
  has_many :job_title_assignments
  has_many :job_titles, through: :job_title_assignments
  has_many :departments, through: :job_title_assignments
end

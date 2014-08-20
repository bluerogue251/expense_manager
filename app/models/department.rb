class Department < ActiveRecord::Base
  validates :name, presence: true
  has_many :job_title_assignments
  has_many :expenses, through: :job_title_assignments
end

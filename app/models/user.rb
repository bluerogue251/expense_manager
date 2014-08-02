class User < ActiveRecord::Base
  include Clearance::User
  validates :name, presence: true

  has_many :job_title_assignments
  has_many :job_titles, through: :job_title_assignments
  has_many :departments, through: :job_title_assignments
end

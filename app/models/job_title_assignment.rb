class JobTitleAssignment < ActiveRecord::Base
  include ReindexExpensesAfterSave

  belongs_to :user
  belongs_to :job_title
  belongs_to :department
  has_many :expense_job_title_assignments
  has_many :expenses, through: :expense_job_title_assignments, class_name: Expense

  validate :starts_on_before_or_equal_to_ends_on

  delegate :name, to: :department, prefix: true, allow_nil: true
  delegate :name, to: :job_title, prefix: true, allow_nil: true

  private

  def starts_on_before_or_equal_to_ends_on
    if starts_on && ends_on && starts_on > ends_on
      errors.add(:starts_on, "must be before or on ends on date")
    end
  end
end

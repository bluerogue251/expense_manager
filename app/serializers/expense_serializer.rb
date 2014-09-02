class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :department_name, :job_title_name, :date, :category_name, :description, :currency, :amount, :status
end

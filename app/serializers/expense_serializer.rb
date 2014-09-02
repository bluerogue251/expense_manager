class ExpenseSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :category_id, :date, :description, :currency, :amount, :status

  has_one :category
end

ExpenseManager.Expense = DS.Model.extend
  date: DS.attr('date')
  category: DS.belongsTo('Category')
  description: DS.attr('string')
  currency: DS.attr('string')
  amount: DS.attr('number')
  status: DS.attr('string')



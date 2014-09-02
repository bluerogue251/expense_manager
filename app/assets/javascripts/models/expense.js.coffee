ExpenseManager.Expense = DS.Model.extend
  date: DS.attr('date')
  description: DS.attr('string')
  currency: DS.attr('string')
  amount: DS.attr('number')
  status: DS.attr('string')


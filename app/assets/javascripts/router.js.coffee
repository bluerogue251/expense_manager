# For more information see: http://emberjs.com/guides/routing/
ExpenseManager.Router.reopen
  location: 'auto'
  rootUrl: '/'

ExpenseManager.Router.map ()->
  @resource('expenses')


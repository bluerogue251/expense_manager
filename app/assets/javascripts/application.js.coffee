#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require expense_manager
#= require jquery_ujs
#= require jquery-ui/datepicker
#= require dataTables/jquery.dataTables
#= require_tree .
#= require_tree ./refills/.

# for more details see: http://emberjs.com/guides/application/
window.ExpenseManager = Ember.Application.create(rootElement: "#ember-app")


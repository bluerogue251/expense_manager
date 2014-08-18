loadServerSideDatatable = (table) ->
  table.dataTable
    iDisplayLength: 10
    bProcessing: true
    bServerSide: true
    sAjaxSource: table.data('source')

$ ->
  loadServerSideDatatable $(".datatable")

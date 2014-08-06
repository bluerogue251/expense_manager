$ ->
  $(document).on 'focus', 'input.datepicker', ->
    $(this).datepicker
      dateFormat: "yy-mm-dd"
    $(this).datepicker('show')

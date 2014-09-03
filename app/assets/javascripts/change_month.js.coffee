$ ->
  $(document).on "click", "a.change-month", (event) ->
    $("li.due").html('<i class="fa fa-spinner fa-spin hidden"></i>')

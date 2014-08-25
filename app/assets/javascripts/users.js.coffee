$ ->
  $("a.destroy_jta").click (e) ->
    $(this).next('input[type="hidden"]').val('1')
    $(this).closest('fieldset').fadeOut()

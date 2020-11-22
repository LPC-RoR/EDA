$(document).on 'click', '.edit_task input[type=checkbox]', ->
  $(this).parent('form').submit()

# alternatively:

ready = ->
  $(document).on 'click', '.edit_task input[type=checkbox]', ->
    $(this).parent('form').submit()

$(document).ready(ready)
$(document).on('page:load', ready)
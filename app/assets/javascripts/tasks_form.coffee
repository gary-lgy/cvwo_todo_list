# TODO: find appropriate event to listen to
$(document).on 'turbolinks:load', ->
  # add a tag on the fly
  $('form').on 'click', '#add_tag', (event) ->
    $(this).before($(this).data('fields'))
    event.preventDefault()

  # remove a tag on the fly
  $('form').on 'click', '#remove_tag', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('div[class=tag]').hide()
    event.preventDefault()

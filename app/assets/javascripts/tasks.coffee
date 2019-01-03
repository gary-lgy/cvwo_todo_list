# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  jQuery ->
    $('form').on 'click', '#add_tag', (event) ->
      $(this).before($(this).data('fields'))
      event.preventDefault()

    $('form').on 'click', '#remove_tag', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('div[class=tag]').hide()
      event.preventDefault()
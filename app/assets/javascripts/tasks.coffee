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

    $('#search-tasks-by-tags').on 'keyup', ->
      search_names = $(this).val().split(' ')
      $('#tasks .card').filter ->
        tag_names = $(this).find('div.tags').text()
        $(this).toggle search_names.every (search_name) ->
          tag_names.indexOf(search_name) > -1


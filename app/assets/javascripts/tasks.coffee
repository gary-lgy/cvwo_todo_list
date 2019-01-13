# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO: move all functions under turbolinks:load such that they will be loaded on page reload
$(document).on 'turbolinks:load', ->
  # convert utc time to local time
  $('.task-deadline-utc').each ->
    $(this).text(moment($(this).text().trim()).format("ddd, D MMM YYYY, kk:mm"))
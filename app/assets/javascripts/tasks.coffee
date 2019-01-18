# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  # convert utc time to local time
  $('.task-deadline-utc').each ->
    $(this).text(moment($(this).text().trim()).format("ddd, D MMM YYYY, kk:mm"))

  # enable all bootstrap tooltips
  $('[data-toggle="tooltip"]').tooltip()
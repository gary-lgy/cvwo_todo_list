# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO: move all functions under turbolinks:load such that they will be loaded on page reload
$(document).on 'turbolinks:load', ->
  # find timezone offset on every page load
  Cookies.set 'timezone_offset', new Date().getTimezoneOffset()
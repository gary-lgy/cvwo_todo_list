# functions used to search for tasks
$(document).on 'turbolinks:load', ->
  # only load on tasks index page
  if $('body.tasks.index').length

    # remove excessive whitespace in a string
    clean_string = (str) ->
      str.trim().replace(/\s+/g, ' ').toLowerCase()
    # convert a string separated by whitespace to an array
    string_to_array = (str) ->
      if str == '' then [] else clean_string(str).split(' ')

    # prevent the task collapse events from propagating to the task groups
    $(document).on 'show.bs.collapse, hide.bs.collapse', '.task', (event) ->
      event.stopPropagation()

    # filter tasks using an array of tag names
    filter_tasks = (tags_to_display) ->
      $('.task').each ->
        tag_names = clean_string($('.task-tags', this).text().trim())
        if tags_to_display.every((tag_to_display) ->
          tag_names.includes(tag_to_display))
          $(this).collapse 'show'
        else
          $(this).collapse 'hide'

    # on search bar value change:
    # filter tasks and toggle tags' active class according to the search items
    $(document).on 'input', '#search-bar', ->
      tags_to_display = string_to_array($('#search-bar').val())
      $('.tag').each ->
        if tags_to_display.includes $(this).text()
          $(this).addClass('active')
        else
          $(this).removeClass('active')
      filter_tasks tags_to_display

    # clear the search box
    $(document).on 'click', '#clear-search-box', (event) ->
      event.preventDefault()
      $('#search-bar').val('')
      $('#search-bar').trigger 'input'

    # when user clicks on a tag, display only the tasks associated with that tag
    $(document).on 'click', '.tag', (event) ->
      event.preventDefault()
      tag_name = $(this).text()
      tags_to_display = string_to_array($('#search-bar').val())
      if tags_to_display.includes(tag_name)
        tags_to_display.splice(tags_to_display.indexOf(tag_name), 1)
      else
        tags_to_display.push(tag_name)
      $('#search-bar').val(tags_to_display.toString().replace(/,/g, ' '))
      $('#search-bar').trigger 'input'

    # open tags list when user clicks on the search area
    $(document).on 'click', '#search-area', (event) ->
      event.stopPropagation()
      $('#all-tags-list').collapse 'show'

    # hide the tags list when user clicks elsewhere
    $(document).on 'click', 'body', ->
      $('#all-tags-list').collapse 'hide'

$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.index').length
    # unbind event handlers before turbolinks caches the page
    $(document).off 'show.bs.collapse, hide.bs.collapse', '.task'
    $(document).off 'input', '#search-bar'
    $(document).off 'click', '#clear-search-box'
    $(document).off 'click', '.tag'
    $(document).off 'click', '#search-area'
    $(document).off 'click', 'body'
    # show all tasks
    $('.task').each ->
      $(this).collapse 'show'

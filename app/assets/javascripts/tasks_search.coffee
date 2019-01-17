# functions used to search for tasks
$(document).on 'turbolinks:load', ->
  # only load on tasks index page
  if $('body.tasks.index').length
    # search for tasks by tags
    filter_tasks_by_search = ->
      search_names = $('#search-bar').val().trim().toLowerCase().split(' ')
      $('.task').each ->
        tag_names = $('.task-tags', this).text().trim().toLowerCase()
        if search_names.toString().length == 0 or search_names.every((search_name) ->
          tag_names.includes(search_name))
          $(this).collapse 'show'
        else
          $(this).collapse 'hide'

    $(document).on 'keyup', '#search-bar', ->
      filter_tasks_by_search()

    # open tags list when user clicks on the search area
    $(document).on 'click', '#search-area', (event) ->
      event.stopPropagation()
      $('#all-tags-list').collapse 'show'

    # hide the tags list when user clicks elsewhere
    $(document).on 'click', 'body', ->
      $('#all-tags-list').collapse 'hide'

    # clear the search box
    $(document).on 'click', '#clear-search-box', (event) ->
      $('#search-bar').val('')
      filter_tasks_by_search()
      event.preventDefault()

    # add tag name to search box upon clicking a tag
    $(document).on 'click', '.tag', (event) ->
      search_bar = $('#search-bar')
      tag_name = $(this).text()
      search_bar.val(search_bar.val() + ' ' + tag_name) unless search_bar.val().split(' ').includes(tag_name)
      filter_tasks_by_search()
      $('#search-area').focus()
      event.preventDefault()

$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.index').length
    # unbind event handlers before turbolinks caches the page
    $(document).off 'keyup', '#search-bar'
    $(document).off 'click', '#search-area'
    $(document).off 'click', 'body'
    $(document).off 'click', '#clear-search-box'
    $(document).off 'click', '.tag'
    # show all tasks
    $('.task').each ->
      $(this).collapse 'show'

# functions used to search for tasks
$(document).on 'turbolinks:load', ->
  # only load on tasks index page
  if $('body.tasks.index').length
    # search for tasks by tags
    filter_tasks_by_search = ->
      search_names = $('#search-tasks-by-tags').val().trim().toLowerCase().split(' ')
      $('.task').each ->
        tag_names = $('.task-tags', this).text().trim().toLowerCase()
        if search_names.toString().length == 0 or search_names.every((search_name) ->
          tag_names.includes(search_name))
          $(this).collapse 'show'
        else
          $(this).collapse 'hide'

    $(document).on 'keyup', '#search-tasks-by-tags', ->
      filter_tasks_by_search()

    # open tags list when the search bar receives focus
    $(document).on 'focus', '#search-tasks-by-tags', ->
      $('#all-tags-list').collapse 'show'

    $(document).on 'blur', '#search-tasks-by-tags', ->
      $('#all-tags-list').collapse 'hide'

    # clear the search box
    $(document).on 'click', '#clear-search-box', (event) ->
      $('#search-tasks-by-tags').val('')
      filter_tasks_by_search()
      event.preventDefault()

    # add tag name to search box upon clicking a tag
    $(document).on 'click', '.tag', (event) ->
      search_box = $('#search-tasks-by-tags')
      tag_name = $(this).text()
      search_box.val(search_box.val() + ' ' + tag_name) unless search_box.val().split(' ').includes(tag_name)
      filter_tasks_by_search()
      event.preventDefault()

$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.index').length
    # unbind event handlers before turbolinks caches the page
    $(document).off 'keyup', '#search-tasks-by-tags'
    $(document).off 'click', '#clear-search-box'
    $(document).off 'click', '.tag'
    $(document).off 'focus', '#search-tasks-by-tags'
    $(document).off 'blur', '#search-tasks-by-tags'
    $('.task').each ->
      $(this).collapse 'show'

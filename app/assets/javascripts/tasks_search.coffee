# functions used to search for tasks
$('.tasks.index').ready ->
  # search for tasks by tags
  filter_tasks_by_search = ->
    search_names = $('#search-tasks-by-tags').val().trim().split(' ')
    $('.task').each ->
      tag_names = $('.task-tags', this).text()
      if search_names.toString().length == 0 or search_names.every((search_name) ->
        tag_names.includes(search_name))
        $(this).collapse 'show'
      else
        $(this).collapse 'hide'

  $('#search-tasks-by-tags').on 'keyup', ->
    filter_tasks_by_search()

  # clear the search box
  $('#clear-search-box').click (event) ->
    $('#search-tasks-by-tags').val('')
    filter_tasks_by_search()
    event.preventDefault()

  # add tag name to search box upon clicking a tag
  $('.tag').click (event) ->
    search_box = $('#search-tasks-by-tags')
    tag_name = $(this).text()
    search_box.val(search_box.val() + ' ' + tag_name) unless search_box.val().split(' ').includes(tag_name)
    filter_tasks_by_search()
    event.preventDefault()

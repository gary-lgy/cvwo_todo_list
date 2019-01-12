$('.tasks.index').ready ->
  # generic function to sort all tasks using a comparator
  sort_tasks_with = (comp_func) ->
    $('#ongoing-tasks .task').sort(comp_func).appendTo('#ongoing-tasks')
    $('#completed-tasks .task').sort(comp_func).appendTo('#completed-tasks')

  # this is the default order
  # sort tasks by time updated (newest on top)
  # using an html data field associated with the task card
  sort_tasks_by_time_updated = ->
    sort_tasks_with (a, b) ->
      if $(a).data('time-updated') > $(b).data('time-updated') then -1 else 1

  # sort tasks by deadline (most urgent on top)
  # using an HTML data field assocaited with the task card
  sort_tasks_by_deadline = ->
    sort_tasks_with (a, b) ->
      a_ddl = $(a).data('deadline')
      b_ddl = $(b).data('deadline')
      # deadline might be blank
      if a_ddl == 0 && b_ddl == 0
        0
      else if a_ddl == 0 || b_ddl == 0
        # those without deadlines are put behind those that do
        if a_ddl == 0 then 1 else -1
      else
        if a_ddl < b_ddl then -1 else 1

  # sort tasks by title (alphabetical order)
  # using the displayed task title
  sort_tasks_by_title = ->
    sort_tasks_with (a, b) ->
      if $(a).find('.task-title').text() < $(b).find('.task-title').text() then -1 else 1

  # sort tasks on page load, based on last used order
  # default order is by time updated
  switch Cookies.get('order')
    when '2' then sort_tasks_by_deadline()
    when '3' then sort_tasks_by_title()
    else sort_tasks_by_time_updated()

  # fire events when user clicks sorting buttons
  $('#sort-tasks-by-time-updated').on 'click', (event) ->
    Cookies.set 'order', '1'
    sort_tasks_by_time_updated()
    event.preventDefault()

  $('#sort-tasks-by-deadline').on 'click', (event) ->
    Cookies.set 'order', '2'
    sort_tasks_by_deadline()
    event.preventDefault()

  $('#sort-tasks-by-title').on 'click', (event) ->
    Cookies.set 'order', '3'
    sort_tasks_by_title()
    event.preventDefault()

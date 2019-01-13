$(document).on 'turbolinks:load', ->
  # only load on tasks index page
  if $('body.tasks.index').length
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
    switch localStorage.getItem 'order'
      when '2'
        $('#sort-tasks-by-deadline').addClass('active')
        sort_tasks_by_deadline()
      when '3'
        $('#sort-tasks-by-title').addClass('active')
        sort_tasks_by_title()
      else
        $('#sort-tasks-by-time-updated').addClass('active')
        sort_tasks_by_time_updated()

    # fire events when user clicks sorting buttons
    $(document).on 'click', '#sort-tasks-by-time-updated', (event) ->
      localStorage.setItem 'order', '1'
      sort_tasks_by_time_updated()
      event.preventDefault()

    $(document).on 'click', '#sort-tasks-by-deadline', (event) ->
      localStorage.setItem 'order', '2'
      sort_tasks_by_deadline()
      event.preventDefault()

    $(document).on 'click', '#sort-tasks-by-title', (event) ->
      localStorage.setItem 'order', '3'
      sort_tasks_by_title()
      event.preventDefault()

$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.index').length
    # unbind all event handlers
    $(document).off 'click', '#sort-tasks-by-time-updated'
    $(document).off 'click', '#sort-tasks-by-deadline'
    $(document).off 'click', '#sort-tasks-by-title'

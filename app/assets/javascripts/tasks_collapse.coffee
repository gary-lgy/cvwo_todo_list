# remember whether the tasks are expanded or collapsed
$(document).on 'turbolinks:load', ->
  if $('body.tasks.index').length
    $(document).on 'show.bs.collapse', '#ongoing-tasks', ->
      localStorage.setItem 'ongoing-collapsed', '0'

    $(document).on 'show.bs.collapse', '#completed-tasks', ->
      localStorage.setItem 'completed-collapsed', '0'

    $(document).on 'hide.bs.collapse', '#ongoing-tasks', ->
      localStorage.setItem 'ongoing-collapsed', '1'

    $(document).on 'hide.bs.collapse', '#completed-tasks', ->
      localStorage.setItem 'completed-collapsed', '1'

    switch localStorage.getItem 'ongoing-collapsed'
      when '1'
        $('#ongoing-tasks').collapse('hide')
      else # expand by default
        $('#ongoing-tasks').collapse('show')
    switch localStorage.getItem 'completed-collapsed'
      when '0'
        $('#completed-tasks').collapse('show')
      else # collapse by default
        $('#completed-tasks').collapse('hide')

$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.index').length
    $(document).off 'show.bs.collapse', '#ongoing-tasks'
    $(document).off 'show.bs.collapse', '#completed-tasks'
    $(document).off 'hide.bs.collapse', '#ongoing-tasks'
    $(document).off 'hide.bs.collapse', '#completed-tasks'
    $(document).off 'mouseenter', '#ongoing-tasks-heading, #completed-tasks-heading'
    $(document).off 'mouseleave', '#ongoing-tasks-heading, #completed-tasks-heading'

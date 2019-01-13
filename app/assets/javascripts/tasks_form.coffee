# function for creating task and editing task
$(document).on 'turbolinks:load', ->
  $('.tasks.edit, .tasks.new').ready ->
    # add a tag on the fly
    $('.add-tag-btn').click (event) ->
      $(this).before($(this).data('fields'))
      $(this).prev().find('#task_tags__name').focus()
      event.preventDefault()

    # remove a tag on the fly
    $('.remove-tag-btn').click (event) ->
      status = $(this).parent().find('#task_tags__status')
      if status.val() == 'existing'
        status.val('remove')
        $(this).parent().hide()
      event.preventDefault()

    # initialize deadline selector
    ddl_selector = $('#deadline-selector')
    options =
      icons:
        time: 'far fa-clock',
        clear: 'far fa-trash-alt',
        close: 'fas fa-times'
      format: 'dddd, D MMMM YYYY, hh:mm a',
      defaultDate: $(ddl_selector).data('current'),
      sideBySide: true,
      buttons:
        showToday: true,
        showClose: true
      allowInputToggle: true
    ddl_selector.datetimepicker(options)

    # add deadline to a input field, if deadline is provided by user
    $('input[type=submit]').click (event) ->
      if ddl_selector.datetimepicker('date') != null
        ddl_seconds = ddl_selector.datetimepicker('date').unix()
        $('form').append('<input type="text" name="task[deadline]" value=' + ddl_seconds + ' style="display: none;">')

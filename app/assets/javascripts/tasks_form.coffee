# TODO: expand description and deadline fields only on demand
# function for creating task and editing task
$(document).on 'turbolinks:load', ->
  # load these functions only for new and edit pages
  if $('body.tasks.edit, body.tasks.new').length
    # add a tag on the fly
    $(document).on 'click', '#add-tag-btn', (event) ->
      event.preventDefault()
      # create a input box for the user to key in the new tag name
      # also creates a hidden status field
      new_tag_field = $('<div class="tag-field">\
        <input type="text" name="task[tags][][name]" autocomplete="off" class="task-tags-name">\
        <input type="hidden" name="task[tags][][status]" value="new" class="task-tags-status">\
        </div>').insertBefore('#add-tag-btn-field')
      new_tag_name = $('.task-tags-name', new_tag_field)

      # automatically shift focus to the newly created field
      new_tag_name.focus()

      # form a tag when the user finishes typing
      new_tag_name.on 'blur', ->
        if $(this).val().trim() == ""
          new_tag_field.remove()
        else
          $(this).hide()
          new_tag_field.append('<div class="tag badge font-italic">' + $(this).val() + '</div> ')
          new_tag_field.append('<a href="#" class="remove-tag-btn">\
            <i class="far fa-trash-alt"></i>\
            </a>')

      # form the tag and open another box when user presses Enter
      new_tag_name.on 'keydown', (event) ->
        if event.key == 'Enter'
          event.preventDefault()
          $(this).trigger 'blur'
          $('#add-tag-btn').trigger 'click'

    # remove a tag
    $(document).on 'click', '.remove-tag-btn', (event) ->
      event.preventDefault()
      status = $(this).siblings('.task-tags-status')
      if status.val() == 'existing'
        status.val('remove')
        $(this).parent().hide()
      else if status.val() == 'new'
        status.parent().remove()

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
    $(document).on 'click', 'input[type=submit]', (event) ->
      if ddl_selector.datetimepicker('date') != null
        ddl_seconds = ddl_selector.datetimepicker('date').unix()
        $('form').append('<input type="text" name="task[deadline]" value=' + ddl_seconds + ' style="display: none;">')

$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.edit, body.tasks.new').length
    # unbind event handlers before turbolinks caches the page
    $(document).off 'click', '#add-tag-btn'
    $(document).off 'click', '.remove-tag-btn'
    $(document).off 'click', 'input[type=submit]'
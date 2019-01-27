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
          # enforce lowercase restriction on tag names
          $(this).val($(this).val().toLowerCase())
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
        close: 'fas fa-times',
        today: 'fas fa-calendar-day'
      format: 'dddd, D MMMM YYYY, hh:mm a',
      defaultDate: $(ddl_selector).data('current'),
      sideBySide: true,
      buttons:
        showToday: true,
        showClose: true
      allowInputToggle: true
    ddl_selector.datetimepicker(options)

    # add deadline to a hidden field
    $(document).on 'click', 'input[type=submit]', (event) ->
      new_ddl_hidden_field = $('<input type=hidden name="task[deadline]">').appendTo('form')
      if ddl_selector.datetimepicker('date') != null
        ddl_seconds = ddl_selector.datetimepicker('date').unix()
        new_ddl_hidden_field.val(ddl_seconds)

    # focus the relevant fields
    # when user presses 'Add Description' or 'Add Deadline'
    $(document).on 'click', '#add-description-btn', (event) ->
      # have to use setTimeout (otherwise focus won't shift because the textarea is not fully shown yet'
      fcs = ->
        $('#task_description').focus()
      setTimeout(fcs, 100)
    $(document).on 'click', '#add-deadline-btn', (event) ->
      fcs = ->
        $('input', ddl_selector).focus()
      setTimeout(fcs, 100)

    # change text on buttons when the fields are shown / collapsed
    $(document).on 'show.bs.collapse', '#description-field', ->
      $('#add-description-btn').text('- Remove Description')
      $('#add-description-btn').attr('id', 'remove-description-btn')
    $(document).on 'show.bs.collapse', '#deadline-field', ->
      $('#add-deadline-btn').text('- Remove Deadline')
      $('#add-deadline-btn').attr('id', 'remove-deadline-btn')

    # remove content and reset button text when user clicks 'Remove Description' or 'Remove Deadline'
    $(document).on 'hide.bs.collapse', '#description-field', ->
      $('textarea', this).val("")
      $('#remove-description-btn').text('+ Add Description')
      $('#remove-description-btn').attr('id', 'add-description-btn')
    $(document).on 'hide.bs.collapse', '#deadline-field', ->
      ddl_selector.datetimepicker('clear')
      $('#remove-deadline-btn').text('+ Add Deadline')
      $('#remove-deadline-btn').attr('id', 'add-deadline-btn')

    # expand description and deadline button if editing a task already with these two fields
    if $('#task_description').val().length
      $('#description-field').collapse 'show'
    if ddl_selector.datetimepicker 'date'
      $('#deadline-field').collapse 'show'


$(document).on 'turbolinks:before-cache', ->
  if $('body.tasks.edit, body.tasks.new').length
    # unbind event handlers before turbolinks caches the page
    $(document).off 'click', '#add-tag-btn'
    $(document).off 'click', '.remove-tag-btn'
    $(document).off 'click', 'input[type=submit]'
    $(document).off 'click', '#add-description-btn'
    $(document).off 'click', '#add-deadline-btn'
    $(document).off 'show.bs.collapse', '#description-field'
    $(document).off 'show.bs.collapse', '#deadline-field'
    $(document).off 'hide.bs.collapse', '#description-field'
    $(document).off 'hide.bs.collapse', '#deadline-field'

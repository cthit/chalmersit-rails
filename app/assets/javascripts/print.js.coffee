# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
printer_local_storage_key = "last-printer-used"
cid_local_storage_key = "cid"

$ ->
  printer_name = localStorage.getItem(printer_local_storage_key)
  cid = localStorage.getItem(cid_local_storage_key)


  if (cid)
    $('#print_username').val(cid)

  if $('#print_printer').length

    $.getJSON($('.printer-list').data('url'))
    .success (printers) ->
      option_tags = printers.map (printer) ->
        $('<option/>')
        .val(printer.name)
        .html(printer.name)
        .data('media', printer.media)
        .data('location', printer.location)
        .data('duplex', printer.duplex)

      printer_suggestions = printers.slice(0, 10).map (printer) ->
        $('<li/>').html($('<a/>').addClass('set-printer').attr('href', 'javascript:;').html(printer.name))

      $('.printer-list').html(printer_suggestions)

      $('#print_printer')
      .html(option_tags)
      .chosen
        no_results_text: 'No matches'
        search_contains: true
        width: '91%'

      if (printer_name)
        $('#print_printer').val(printer_name).trigger('chosen:updated')

      $('#print_printer').trigger 'change'

    $('.get-pq-button').on 'click', ->
      $that = $(this)
      $that.prop 'disabled', true
      $('#pq .alert-box').hide()
      $('#pq .done').toggle()
      $.ajax
        url: $('#pq').data('url')
        type: 'POST'
        data:
          username: $('#print_username').val()
          password: $('#print_password').val()
      .success (data) ->
        $that.prop 'disabled', false
        $('#pq .done').toggle()
        if data.error
          $('#pq .alert .error').text(data.error)
          $('#pq .alert').show()
        else
          $('#pq .name').text(data.username)
          $('#pq .pq').text(data.value)
          $('#pq .success').show()
          localStorage.setItem(cid_local_storage_key, data.username)


    $('.printer-list').on 'click', '.set-printer', ->
      $('#print_printer').val this.textContent
      $('#print_printer').trigger 'chosen:updated'
      $('#print_printer').trigger 'change'

    $('#print_printer').on 'change', ->
      selected = $ 'option:selected', this
      setMedia selected.data('media').split(' ')
      setDuplexEnabled selected.data('duplex')

      printer_name = this.value
      localStorage.setItem(printer_local_storage_key, printer_name)

    $('#new_print').on 'submit', (e) ->
      e.preventDefault()
      form = new FormData(this)
      newCid = $('#print_username').val()

      $.ajax
        url: this.action,
        type: 'POST',
        data: form,
        processData: false
        contentType: false
      .success (data) ->
        $('.printer-feedback-alert').hide()
        $('.printer-feedback-success').show()
        localStorage.setItem(cid_local_storage_key, newCid)
      .error (err) ->
        errors = err.responseJSON.errors
        $('.printer-feedback-alert .msg').html($('<ul/>').html(errors.map (err) -> $('<li/>').text(err)))
        $('.printer-feedback-alert').show()
        $('.printer-feedback-success').hide()
        console.error errors
      .always ->
        $.rails.enableFormElement($('[data-disable-with]'))

setMedia = (medias) ->
  $media = $('#print_media')
  $media.html('')
  medias = medias.map (m) ->
    $('<option>').val(m).html(m)

  $media.html(medias)

setDuplexEnabled = (hasDuplexSupport) ->
  $('#print_duplex')
  .prop('checked', hasDuplexSupport)
  .attr('disabled', !hasDuplexSupport)

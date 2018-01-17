# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
printer_local_storage_key = "last-printer-used"

$ ->
  printer_name = localStorage.getItem(printer_local_storage_key)
  if (printer_name)
    $('#print_printer').val printer_name

  if $('#print_printer').length
    $('#print_printer').chosen
      no_results_text: 'No matches'
      search_contains: true
      width: '91%'

    $('.get-pq-button').on 'click', ->
      $that = $(this)
      $that.prop 'disabled', true
      $('#pq .alert-box').hide()
      $('#pq .done').toggle()
      $.ajax
        url: '/print/pq.json'
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


    $('.printer-list').on 'click', '.set-printer', ->
      $('#print_printer').val this.textContent
      $('#print_printer').trigger 'chosen:updated'
      $('#print_printer').trigger 'change'

    $('#print_printer').on 'change', ->
      selected = $ 'option:selected', this
      setMedia selected.data('media').split(' ')
      printer_name = this.value
      localStorage.setItem(printer_local_storage_key, printer_name)

    $('#new_print').on 'submit', (e) ->
      e.preventDefault()
      form = new FormData(this)

      $.ajax
        url: this.action,
        type: 'POST',
        data: form,
        processData: false
        contentType: false
      .success (data) ->
        console.log data
      .error (err) ->
        console.error err.responseJSON.errors


    setMedia $('#print_printer option:selected').data('media').split(' ')


setMedia = (medias) ->
  $media = $('#print_media')
  $media.html('')
  medias = medias.map (m) ->
    $('<option>').val(m).html(m)

  $media.html(medias)

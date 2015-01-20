# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#print_printer').chosen
    no_results_text: 'No matches'
    search_contains: true

  $('.printer-list').on 'click', '.set-printer', ->
    console.log(this.textContent)
    $('#print_printer').val this.textContent
    $('#print_printer').trigger 'chosen:updated'
    $('#print_printer').trigger 'change'

  $('#print_printer').on 'change', ->
    selected = $ 'option:selected', this
    setMedia selected.data('media').split(' ')

  setMedia $('#print_printer option:selected').data('media').split(' ')


setMedia = (medias) ->
  $media = $('#print_media')
  $media.html('')
  medias = medias.map (m) ->
    $('<option>').val(m).html(m)

  $media.html(medias)

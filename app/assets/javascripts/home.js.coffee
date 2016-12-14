# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
card_number_local_storage_key = "student-union-card"
$ ->
  getStudentUnionCardBalance = (card_number) ->
    $.get getUrlForLocale(card_number), (data) ->
      $('#student-union-card').html(data)
      localStorage.setItem(card_number_local_storage_key, card_number)
    .fail (data, error) ->
      jsonParse = data.responseJSON
      $('#student-union-error').addClass("message alert-box")
      $('#student-union-error').text(jsonParse.error)

  getUrlForLocale = (card_number) ->
    if (I18n.locale)
      "/#{I18n.locale}/home/card_balance/#{card_number}"
    else
      "/home/card_balance/#{card_number}"

  $('.it_twitter').each ->
    $this = $(this)
    handle = $this.data('handle')
    $this.find('.tweet-list').load("/twitter/feed/#{handle}?count=6")

  $.get $('.lunch-loader').attr('data-url'), (data) ->
    $('.lunch-loader').replaceWith(data)

  $('.it-calendar').load($('.it-calendar').attr('data-url'))

  $('#student-union-card').on 'click', '#card-balance-submit', ->
    $('#student-union-error').removeClass("message alert-box")
    $('#student-union-error').text("")
    card_number = $('#student-union-card-number').val()
    getStudentUnionCardBalance(card_number)

  oc = $('#student-union-card').html()
  $('#student-union-card').on 'click', '#student-union-exit', ->
    localStorage.removeItem(card_number_local_storage_key)
    $('#student-union-card').html(oc)

  card_number = localStorage.getItem(card_number_local_storage_key)
  if (card_number)
    $('#student-union-card form').remove()
    getStudentUnionCardBalance(card_number)

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
card_number_local_storage_key = "student-union-card"

loading_indicator = $("<div class='loading-indicator'>
      <i class='fa fa-credit-card loading-indicator-feature'></i>
      <div class='loading-indicator-text'>#{I18n.t('loading')}...</div>
    </div>")

$ ->
  original_card_html = $('#student-union-card').html()

  getStudentUnionCardBalance = (card_number) ->
    if card_number == ""
      $('#student-union-error').addClass("message alert-box")
      $('#student-union-error').text("Empty card number")
    else
      $('#student-union-card').html(loading_indicator)
      $.get getUrlForLocale(card_number), (data) ->
        $('#student-union-card').html(data)
        localStorage.setItem(card_number_local_storage_key, card_number)
      .fail (data, error) ->
        jsonParse = data.responseJSON
        $('#student-union-card').html(original_card_html)
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

  $.get $('.calendar-loader').attr('data-url'), (data) ->
    $('.calendar-loader').replaceWith(data)

  $('#student-union-card').on 'click', '#card-balance-submit', ->
    $('#student-union-error').removeClass("message alert-box")
    $('#student-union-error').text("")
    card_number = $('#student-union-card-number').val()
    getStudentUnionCardBalance(card_number)

  $('#student-union-card').on 'click', '#student-union-exit', ->
    localStorage.removeItem(card_number_local_storage_key)
    $('#student-union-card').html(original_card_html)

  card_number = localStorage.getItem(card_number_local_storage_key)
  if (card_number)
    $('#student-union-card form').remove()
    getStudentUnionCardBalance(card_number)

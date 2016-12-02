# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.it_twitter').each ->
    $this = $(this)
    handle = $this.data('handle')
    $this.find('.tweet-list').load("/twitter/feed/#{handle}?count=6")

  $('.lunch_feed').load($('.lunch_feed').attr('data-url'))
  $('.it-calendar').load($('.it-calendar').attr('data-url'))

  $('#card-balance-submit').on 'click', ->
    card_number = $('#student-union-card-number').val()
    $('#student-union-card').load("/home/card_balance/#{card_number}")

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.it_twitter').each ->
    $this = $(this)
    handle = $this.data('handle')
    $this.find('.tweet-list').load("/twitter/feed/#{handle}?count=6")

  $.get $('.lunch-loader').attr('data-url'), (data) ->
    $('.lunch-loader').replaceWith(data)

  $.get $('.calendar-loader').attr('data-url'), (data) ->
    $('.calendar-loader').replaceWith(data)

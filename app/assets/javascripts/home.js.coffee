# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.it_twitter').each ->
    $this = $(this)
    handle = $this.data('handle')
    $this.find('.tweet-list').load("/twitter/feed/#{handle}?count=6")

  $('.lunch_feed').load('/lunch/feed/')


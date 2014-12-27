# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.it_twitter').each ->
    $this = $(this)
    console.log this
    handle = $this.data('handle')
    $this.load("/twitter/feed/#{handle}?count=6")

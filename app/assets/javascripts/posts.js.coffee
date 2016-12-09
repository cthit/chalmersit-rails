# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('article time').each (index, elem) ->
    $elem = $(elem)
    datetime = $elem.attr 'datetime'
    moment.locale(I18n.locale)
    $elem.text moment(new Date(datetime)).fromNow()


  $('.preview').on 'click', ->
    textid = $(this).data('text')
    titleid = $(this).data('title')
    title = $(titleid).val()
    text = $(textid).val()
    $.post '/preview', { text: text }, (body) ->
      $preview = $('#preview')
      $preview.find('.post-title').text(title)
      $preview.find('.article-content').html(body)
      $preview.foundation('reveal', 'open')
    false

  $('.posts #post_event_attributes__destroy').on 'change', ->
    $('#event_fields_container').toggle this.checked

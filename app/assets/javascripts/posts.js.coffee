# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('time').each (index, elem) ->
    $elem = $(elem)
    datetime = $elem.attr 'datetime'
    $elem.text moment(new Date(datetime)).fromNow()

  $('.posts #post_body').fileupload
    url: '/images.json',
    paramName: 'image[source]',
    add: (e, data) ->
      data.orig_name = data.files[0].name
      data.progress_bar = $('<progress max="100" value="0">').insertAfter(this)
      data.label = $('<label>').insertAfter(data.progress_bar)
      data.submit()
    progress: (e, data) ->
      percent = parseInt(data.loaded / data.total * 100, 10)
      if percent < 99
        data.progress_bar.val(percent)
        data.label.text(percent + '%')
      else
        data.progress_bar.removeAttr('value')
        data.label.text('Resizing...')
    done: (e, data) ->
      data.progress_bar.remove()
      data.label.remove()
      src = data.result.source
      insertTextAtCaret(this, link_to_image_markdown(data.orig_name, src.url, src.thumb.url))

insertTextAtCaret = (elem, text) ->
  $elem = $(elem)
  caretPos = elem.selectionStart
  oldText = $elem.val()
  $elem.val(oldText.substring(0, caretPos) + text + oldText.substring(caretPos))

link_to_image_markdown = (title, url, url_thumb) ->
  if url_thumb
    "[![#{title}](#{url_thumb})](#{url})"
  else
    "![#{title}](#{url})"


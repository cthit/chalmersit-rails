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
      data.orig_name = remove_ext data.files[0].name
      data.progress_bar = $('<progress max="100" value="0" class="image-upload">').insertAfter(this)
      data.label = $('<label>').insertAfter(data.progress_bar)
      data.submit()
    progress: (e, data) ->
      percent = parseInt(data.loaded / data.total * 100, 10)
      if percent < 99
        data.progress_bar.val(percent)
        data.label.text("Uploading #{data.orig_name}:  #{percent}%")
      else
        data.progress_bar.removeAttr('value')
        data.label.text("Resizing #{data.orig_name}…")
    done: (e, data) ->
      data.progress_bar.remove()
      data.label.remove()
      src = data.result.source
      insertTextAtCaret(this, image_thumbnail_markdown(data.orig_name, src.url, src.thumb.url) + "\n")

insertTextAtCaret = (elem, text) ->
  $elem = $(elem)
  caretPos = elem.selectionStart
  oldText = $elem.val()
  $elem.val(oldText.substring(0, caretPos) + text + oldText.substring(caretPos))

image_markdown = (title, url) ->
  "![#{title}](#{url})"

link_markdown = (text, url) ->
    "[#{text}](#{url})"

image_thumbnail_markdown = (title, url, url_thumb) ->
  if url_thumb
    link_markdown(image_markdown(title, url_thumb), url)
  else
    image_markdown(title, url)

remove_ext = (filename) ->
  filename.substr(0, filename.lastIndexOf('.'))

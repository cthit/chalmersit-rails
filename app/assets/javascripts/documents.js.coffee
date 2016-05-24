$ ->
  post_body = '.posts #post_body_en, .posts #post_body_sv, #page_body'

  $(post_body + ', #post_document_upload, #page_document_upload').fileupload
    url: '/documents.json',
    paramName: 'document[document]',
    add: (e, data) ->
      if data.files[0].name
        data.orig_name = remove_ext data.files[0].name
      else
        data.orig_name = 'document'
      data.progress_bar = $('<progress max="100" value="0" class="document-upload">').insertAfter($(post_body))
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
      src = data.result.document
      insertTextAtCaret($(post_body), link_markdown(data.orig_name, src.url) + "\n")

insertTextAtCaret = (elem, text) ->
  $elem = $(elem)
  caretPos = elem.selectionStart
  oldText = $elem.val()
  $elem.val(oldText.substring(0, caretPos) + text + oldText.substring(caretPos))

link_markdown = (text, url) ->
    "[#{text}](#{url})"

remove_ext = (filename) ->
  filename.substr(0, filename.lastIndexOf('.'))

image_exts = [".jpg", ".jpeg", ".gif", ".png", ".webp"]
doc_exts = [".pdf", ".md", ".txt"]
post_body = '.posts #post_body_en, .posts #post_body_sv, #page_body_sv, #page_body_en'
en_post_body = '.posts #post_body_en, #page_body_en'
sv_post_body = '.posts #post_body_sv, #page_body_sv'

$ ->
  new Clipboard('.copy-file')

  $(en_post_body + sv_post_body).fileupload
    url: '/uploads.json',
    paramName: 'upload[source]',
    add: (e, data) ->
      data.progress_bar = $('<progress max="100" value="0" class="image-upload">').insertAfter($(post_body))
      data.label = $('<label>').insertAfter(data.progress_bar)
      try
        unless valid_file(data.files[0].name)
          handle_file_error(data)
        if data.files[0].name
          data.orig_name = data.files[0].name
        else
          data.orig_name = 'image'
        data.submit().error (e) ->
          handle_file_error(data)
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
      extension = src.url.substr(src.url.lastIndexOf('.'), src.url.length)
      if $.inArray(extension, image_exts) > -1
        add_to_file_list(data.orig_name, src.url, image_thumbnail_markdown(remove_ext(data.orig_name), src.url, src.thumb.url))
      else
        add_to_file_list(data.orig_name, src.url, link_markdown(remove_ext(data.orig_name), src.url))

  $(post_body).on 'paste', (event) ->
    post_body = event.currentTarget
    pasted_text = event.originalEvent.clipboardData.getData('text')
    caret_position = post_body.selectionStart
    if pasted_text.indexOf("![") == -1 #Ignore images with thumbnails
      #Paste event is fired before data is pasted, wait 100ms to make sure that the text is there.
      setTimeout ( ->
          first_pos = post_body.value.indexOf(pasted_text, caret_position)
          last_pos = first_pos + pasted_text.indexOf("]")
          post_body.setSelectionRange(first_pos + 1, last_pos)

      ), 100

handle_file_error = (data) ->
  data.label.text I18n.t('unsupported_file_format')
  data.progress_bar.remove()
  setTimeout ->
    data.label.remove()
  , 10000

valid_file = (filename) ->
  extension = filename.substr(filename.lastIndexOf('.'), filename.length)
  $.inArray(extension, image_exts) || $.inArray(extension, doc_exts)

add_to_file_list = (filename, url, markdown_url) ->
  content = "<div class='file-entry'>
              <a target='_blank' title='#{filename}' href='#{url}'> #{filename} </a>
              <button class='button tiny copy-file' data-clipboard-text='#{markdown_url}'> #{I18n.t('copy_link')} </button>
            </div>"
  $("#file-list").append(content)

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

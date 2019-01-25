image_exts = [".jpg", ".jpeg", ".gif", ".png", ".webp"]
doc_exts = [".pdf", ".md", ".txt"]
post_body = '.posts #post_body_en, .posts #post_body_sv, #page_body_sv, #page_body_en'
file_uploaders = '#post_image_uploader_en, #post_image_uploader_sv, #page_image_uploader_sv, #page_image_uploader_en'

#  Not proud of this solution. But without it we don't get to have two
# uploaders on the same page (tries to upload the file once for each uploader)
last_upload_name = ""

$ ->
  new Clipboard('.copy-file')

  $(file_uploaders).fileupload
    url: '/uploads.json',
    paramName: 'upload[source]',
    add: (e, data) ->
      this_upload_name = data.files[0].name
      unless last_upload_name == this_upload_name &&
        last_upload_name = this_upload_name
        data.progress_bar = $('<progress max="100" value="0" class="image-upload">').insertAfter($('.attach-files'))
        data.label = $('<label>').insertAfter(data.progress_bar)
        try
          unless valid_file(this_upload_name)
            handle_file_error(data)
          else
            if this_upload_name
              data.orig_name = this_upload_name
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
      if image_exts.includes(extension)
        add_to_file_list(data.orig_name, src.url, image_markdown(remove_ext(data.orig_name), src.url))
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
  image_exts.includes(extension) || doc_exts.includes(extension)

add_to_file_list = (filename, url, markdown_url) ->
  unhide_file_list()

  content = "<div class='file-entry'>
              <a target='_blank' title='#{filename}' href='#{url}'> #{filename} </a>
              <button class='button tiny copy-file' data-clipboard-text='#{markdown_url}'> #{I18n.t('copy_link')} </button>
            </div>"
  $("#file-list").append(content)

unhide_file_list = () ->
  $('.file-list-container').removeClass('hidden')

image_markdown = (title, url) ->
  "![#{title}](#{url})"

link_markdown = (text, url) ->
  "[#{text}](#{url})"

remove_ext = (filename) ->
  filename.substr(0, filename.lastIndexOf('.'))

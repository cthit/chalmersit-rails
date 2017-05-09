class CarrierWaveCropper
  constructor: ->
    $('#banner_image_cropbox').Jcrop
      aspectRatio: 0
      setSelect: [0, 0, 200, 200]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    box = $('#banner_image_cropbox')
    widthRatio = box[0].width/box.width()
    heightRatio = box[0].height/box.height()
    $('#banner_image_crop_x').val(coords.x*widthRatio)
    $('#banner_image_crop_y').val(coords.y*heightRatio)
    $('#banner_image_crop_w').val(coords.w*widthRatio)
    $('#banner_image_crop_h').val(coords.h*heightRatio)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#banner_image_previewbox').css
      width: Math.round(100/coords.w * $('#banner_image_cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#banner_image_cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'

new CarrierWaveCropper()

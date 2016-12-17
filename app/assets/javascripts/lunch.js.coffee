$ ->
  toggleLunch = ->
    $('#lunches').toggle()
    $('#hide-lunch').toggle()
    $('#show-lunch').toggle()

  $('#show-lunch').on 'click', ->
    toggleLunch()

  $('#hide-lunch').on 'click', ->
    toggleLunch()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  players = $('#pick_player_id').html()
  $('#pick_team_id').change ->
    team = $('#pick_team_id :selected').text()
    options = $(players).filter("optgroup[label='#{team}']").html()
    if options
      $('#pick_player_id').html(options)
    else
      $('#pick_player_id').empty()


@paintIt = (element, backgroundColor, textColor) ->
  element.style.backgroundColor = backgroundColor
  if textColor?
    element.style.color = textColor

$ ->
  $("a[data-background-color]").click (e) ->
    e.preventDefault()

    backgroundColor = $(this).data("background-color")
    textColor = $(this).data("text-color")
    paintIt(this, backgroundColor, textColor)

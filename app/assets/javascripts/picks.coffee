# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#pick_player_id').parent().hide()
  players = $('#pick_player_id').html()
  $('#player_team_id').change ->
    team = $('#player_team_id :selected').text()
    escaped_team=team.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
    options = $(players).filter("optgroup[label='#{escaped_team}']").html()
    if options
      $('#pick_player_id').html(options)
      $('#pick_player_id').parent().show()
    else
      $('#pick_player_id').empty()
      $('#pick_player_id').parent().hide()

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

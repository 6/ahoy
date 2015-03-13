class @ComposeMessageView extends Backbone.View
  enterKeyCode: 13
  events:
    'keydown textarea': "onKeyDown"

  initialize: ->
    @$('textarea').maxlength({
      alwaysShow: true
      separator: " of "
      limitReachedClass: "label label-warning"
      placement: "bottom"
    })

  # Don't allow newlines
  onKeyDown: (e) ->
    if e.which == @enterKeyCode
      e.preventDefault()

class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="assets/<%= String(rankName).toLowerCase() %>-<%= suitName.toLowerCase() %>.png" />'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    if !@model.get 'revealed'
      @$el.html @template rankName: 'card', suitName: 'back'
    else
      @$el.html @template @model.attributes
    # @$el.addClass 'covered' unless @model.get 'revealed'
    @

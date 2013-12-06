class window.BankView extends Backbone.View

  className: 'bottom'

  template: _.template '<span class="logo">Black Jack</span><div class="money"> Bank: <strong><%= bank %></strong>
    Pot: <strong><%= pot %></strong></div>'

  initialize: ->
    @render()
    vents.on('change:pot', @render, @)

  render: ->
    @$el.html @template(@model.toJSON())
    @
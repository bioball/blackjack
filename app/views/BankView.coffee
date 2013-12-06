class window.BankView extends Backbone.View

  className: 'bottom'

  template: _.template '<span class="logo">Black Jack</span><div class="money"> Bank: <strong><%= bank.formatMoney(0) %></strong>
    Pot: <strong><%= pot.formatMoney(0) %></strong></div>'

  initialize: ->
    @render()
    vents.on('change:pot', @render, @)

  render: ->
    @$el.html @template(@model.toJSON())
    @
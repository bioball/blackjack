app = new App()
window.vents = _.extend({}, Backbone.Events)

Number::formatMoney = (places, symbol, thousand, decimal) ->
  places = (if not isNaN(places = Math.abs(places)) then places else 2)
  symbol = (if symbol isnt `undefined` then symbol else "$")
  thousand = thousand or ","
  decimal = decimal or "."
  number = this
  negative = (if number < 0 then "-" else "")
  i = parseInt(number = Math.abs(+number or 0).toFixed(places), 10) + ""
  j = (if (j = i.length) > 3 then j % 3 else 0)
  symbol + negative + ((if j then i.substr(0, j) + thousand else "")) + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + ((if places then decimal + Math.abs(number - i).toFixed(places).slice(2) else ""))

new AppView(model: app).$el.appendTo 'body'
new BankView(model: app).$el.appendTo 'body'
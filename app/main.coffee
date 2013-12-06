app = new App()
window.vents = _.extend({}, Backbone.Events)

new AppView(model: app).$el.appendTo 'body'
new BankView(model: app).$el.appendTo 'body'
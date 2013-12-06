class window.AppView extends Backbone.View

  template: _.template '
    <div class="button-container"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .playagain": ->
      $('body').html('')
      new AppView(model: new App()).$el.appendTo 'body'

  initialize: ->
    @model.beforeGame()
    @render()
    self = @
    @model.on 'dealerwin', => @endGame('lose')
    @model.on 'playerwin', => @endGame('win')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  playAgain: ->
    $('body').html('')
    new AppView(model: new App()).$el.appendTo 'body'

  endGame: (context) ->
    $('.button-container').html('')
    $('body').append('<div class="endgame"></div>')
    endgamediv = $('.endgame')
    endgamediv.animate(opacity: 0.5, 1000, 'swing', =>
      $('body').append("<div class=\"endgametext\"><span class=\"#{context}text\">You #{context}!</span><button class=\"playagain\">Play again?</button></div>")
      $('button').on('click', => @playAgain())
      )
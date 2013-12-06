class window.AppView extends Backbone.View

  template: _.template '
    <div class="button-container">
      <input type="text" class="betfield"></input>
      <button class="submit">Bet</button>
    </div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @model.beforeGame()
    @render()
    self = @
    @$el.find('.betfield').maskMoney(symbol: '$', precision: 0)
    @$el.find('.submit').on('click', -> self.bet() )
    @model.on 'dealerwin', => @endGame('lose')
    @model.on 'playerwin', => @endGame('win')
    @model.on 'betDone', @renderButtons, @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderButtons: ->
    @$el.find('.button-container').html('<button class="hit-button">Hit</button>
      <button class="stand-button">Stand</button>')

  playAgain: ->
    $('.endgame').remove()
    $('.endgametext').remove()
    @model.off()
    new AppView(model: @model).$el.appendTo 'body'
    $('html, body').animate(scrollTop: $(document).height(), 'slow')

  endGame: (context) ->
    $('.button-container').html('')
    $('body').append('<div class="endgame"></div>')
    endgamediv = $('.endgame')
    endgamediv.animate(opacity: 0.5, 1000, 'swing', =>
      $('body').append("<div class=\"endgametext\"><span class=\"#{context}text\">You #{context}!</span><button class=\"playagain\">Play again?</button></div>")
      $('button').on('click', => @playAgain())
      )

  bet: ->
    betAmount = $('.betfield').val()
    $('.betfield').val('')
    @model.set 'bank', parseInt(@model.get('bank'), 10) - parseInt(betAmount, 10)
    @model.set 'pot', parseInt(@model.get('pot'), 10) + (parseInt(betAmount, 10) * 2)
    vents.trigger('change:pot')
    @model.startGame();



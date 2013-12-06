#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'bank', 50000
    @set 'pot', 0

  beforeGame: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

  startGame: ->
    @flipCards()
    @trigger('betDone')
    @get('playerHand').on 'stand', =>
      @get('dealerHand').at(0).flip()
      @get('dealerHand').dealerPlay()

    @get('playerHand').on 'bust', =>
      @trigger('dealerwin')
      @set 'pot', 0
      vents.trigger('change:pot')

    @get('dealerHand').on 'bust', =>
      @trigger('playerwin')
      @set 'bank', @get('bank') + @get('pot')
      @set 'pot', 0
      vents.trigger('change:pot')

    @get('dealerHand').on 'stand', =>
      playerScore = @finalScore(@get('playerHand').scores())
      dealerScore = @finalScore(@get('dealerHand').scores())
      if playerScore > dealerScore
        @trigger('playerwin')
        @set 'bank', @get('bank') + @get('pot')
        @set 'pot', 0
        vents.trigger('change:pot')
      else
        @trigger('dealerwin')
        @set 'pot', 0
        vents.trigger('change:pot')

  finalScore: (scores) ->
    if scores[1] && scores[1] <= 21
      scores[1]
    else
      scores[0]

  flipCards: ->
    @get('playerHand').at(0).flip()
    @get('playerHand').at(1).flip()
    @get('dealerHand').at(1).flip()
#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'bank', 50000
    @set 'pot', 0
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

  beforeGame: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @startGame()

  startGame: ->
    @get('playerHand').on 'stand', =>
      @get('dealerHand').at(0).set('revealed', true)
      @get('dealerHand').dealerPlay()

    @get('playerHand').on 'bust', => @trigger('dealerwin')
    @get('dealerHand').on 'bust', => @trigger('playerwin')

    @get('dealerHand').on 'stand', =>

      playerScore = @finalScore(@get('playerHand').scores())
      dealerScore = @finalScore(@get('dealerHand').scores())


      if playerScore > dealerScore
        @trigger('playerwin')
      else
        @trigger('dealerwin')

  finalScore: (scores) ->
    if scores[1] && scores[1] <= 21
      scores[1]
    else
      scores[0]
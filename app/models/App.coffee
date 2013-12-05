#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', =>
      @get('dealerHand').at(0).set('revealed', true)
      @get('dealerHand').hit()

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
    if(scores[1])
      if(scores[1] <= 21)
        scores[1]
      else
        scores[0]
    else
      scores[0]
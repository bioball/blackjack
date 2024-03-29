class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if !@deck.length then @deck.initialize()
    @add(@deck.pop())
    console.log("someone hit. deck is: ", @deck.length)
    if @scores()[0] > 21 then @bust()
    @last()

  bust: ->
    @trigger('bust')

  stand: ->
    @trigger('stand')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or ((card.get('value') is 1) and (card.get('revealed')))
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  dealerPlay: ->
    if (@scores()[0] >= 17 && @scores()[0] <= 21) or (@scores()[1] >= 17 && @scores()[1] <= 21)
      @stand()
    else if @scores()[0] > 21
      return
    else
      @hit()
      @dealerPlay()
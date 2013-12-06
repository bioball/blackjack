class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: ->
    if @length <= 1 then @initialize()
    hand = new Hand [ @pop().flip(), @pop().flip() ], @
    console.log('deal player. deck is ', @length)
    hand

  dealDealer: ->
    if @length <= 1 then @initialize()
    hand = new Hand [ @pop().flip(), @pop().flip() ], @, true
    console.log('deal dealer. deck is', @length)
    hand
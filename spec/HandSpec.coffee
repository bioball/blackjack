describe 'hand', ->

  deck = null
  playerHand = null
  dealerHand = null


  beforeEach ->
    deck = new Deck()
    playerHand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'player', ->
    it "should trigger bust if above 21", ->
      spy = sinon.spy(playerHand, 'bust')
      kingOfHearts = new Card(rank: 0, suit: 3)
      queenOfHearts = new Card(rank: 12, suit: 3)
      fiveOfDiamonds = new Card(rank: 5, suit: 1)
      deck.add([kingOfHearts, queenOfHearts, fiveOfDiamonds])

      # remove all cards from the player hand
      playerHand.pop()
      playerHand.pop()

      # the player is a sucker and keeps on hitting
      playerHand.hit()
      playerHand.hit()
      playerHand.hit()

      expect(spy.called).toBe(true)
      expect(playerHand.scores()[0]).toEqual(25)

    it "should be able to stand", ->
      expect(typeof playerHand.stand).toEqual("function")

  describe "dealer", ->
    it 'should stop hitting once it breaks 18', ->
      kingOfHearts = new Card(rank: 0, suit: 3)
      queenOfHearts = new Card(rank: 12, suit: 3)
      deck.add([kingOfHearts, queenOfHearts])

      spy = sinon.spy(dealerHand, 'hit')

      dealerHand.pop()
      dealerHand.pop()

      dealerHand.dealerPlay()

      expect(spy.calledTwice).toBe(true)


    it 'should stop hitting once it busts', ->

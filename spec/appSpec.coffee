describe "app", ->
  app = null

  beforeEach ->
    app = new App()

  describe 'player stand', ->
    it 'should shift hit to dealer', ->
      dealerSpy = sinon.spy(app.get('dealerHand'), 'dealerPlay')
      app.get('playerHand').stand()
      expect(dealerSpy.called).toBe(true)

    it 'should not call hit on the player hand', ->
      playerSpy = sinon.spy(app.get('playerHand'), 'hit')
      $('.stand-button').trigger('click')
      expect(playerSpy.called).toBe(false)
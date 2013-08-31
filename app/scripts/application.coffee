###global define###
define ['game', 'jquery'], (Game, $) ->
    'use strict'

    Application = ()->
    	@game = new Game()
    	$('.new-game').on 'click', @game.clearGame
    	$('.clear-score').on 'click', @game.clearScore
    	return
    
    Application

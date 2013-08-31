###global define###
define ['store', 'jquery'], (store, $) ->
	'use strict'

	Game = ()->
		store.remove 'winner'
		@$game = $ '.game'
		@$game.on 'click', 'td', @mark
		@$game.on 'marked', 'td', @drawWinner
		@$game.on 'clearGame', 'td', @clearGame
		if !store.get 'P1'
			store.set 'P1', 0
		if !store.get 'P2'
			store.set 'P2', 0
		$('.well span').text("P1(#{store.get('P1')}) x P2(#{store.get('P2')})")
		return

	Game.prototype.clearGame = ()->
		if confirm 'Would you like to restart the game?'
			window.turn = 'X'
			$('td').each(()->
				$(@).attr 'class', ''
				$(@).text ''
			)

	Game.prototype.clearScore = ()->
		store.set 'P1', 0
		store.set 'P2', 0
		$('.well span').text("P1(#{store.get('P1')}) x P2(#{store.get('P2')})")

	Game.prototype.drawWinner = ()->
		$('td').each((i)->
			#vertical testing
			column = ''
			$("td:nth-child(#{i}),td:nth-child(#{i+3}),td:nth-child(#{i+6})").each(()->
				column += "#{$(@).attr('class')},"
				if column is 'marked X animated bounce,marked X animated bounce,marked X animated bounce,' or column is 'marked O animated bounce,marked O animated bounce,marked O animated bounce,'
					winner = if $(@).text() is 'X' then 'P1' else 'P2'
					store.set(winner, store.get(winner)+1)
					alert = "<div class='alert alert-info alert-dismissable'>
		              <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
		              The winner is #{winner}
		            </div>"
					$('.well').after alert
					$('.well span').text("P1(#{store.get('P1')}) x P2(#{store.get('P2')})")
					$(@).trigger 'clearGame'
			)

			# horizontal testing
			if $(@).prev().hasClass('marked') and $(@).next().hasClass('marked') and $(@).hasClass('marked')
				if ($(@).prev().attr('class') is $(@).next().attr('class')) and ($(@).prev().attr('class') is $(@).attr('class'))
					winner = if $(@).text() is 'X' then 'P1' else 'P2'
					store.set(winner, store.get(winner)+1)
					alert = "<div class='alert alert-info alert-dismissable'>
		              <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
		              The winner is #{winner}
		            </div>"
					$('.well').after alert
					$('.well span').text("P1(#{store.get('P1')}) x P2(#{store.get('P2')})")
					$(@).trigger 'clearGame'
		)
		if $('td.marked').length is 9
			alert 'The game is tied!'
			$(@).trigger 'clearGame'


	Game.prototype.mark = ()->
		if !$(@).hasClass 'marked'
	    	turn = window.turn || 'X'
	    	$(@).text turn
	    	$(@).addClass "marked #{turn} animated bounce"
	    	turn = if turn == 'X' then 'O' else 'X'
	    	window.turn = turn
	    	$(@).trigger 'marked'
	    	return

	Game
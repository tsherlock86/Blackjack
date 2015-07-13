#!/usr/bin/env ruby
require_relative 'Deck'

class Game

  attr_accessor :deck,
                :player_hand,
                :dealer_hand,
                :player_win,
                :dealer_win

  def initialize(deck = Deck.new)
    @deck = deck
    @player_hand = player_hand
    @dealer_hand = dealer_hand
    @player_win = 0
    @dealer_win = 0
    first_hand
  end
  #gives player nad dealer two cards. Welcome them to the game and tells them what dealer is showing and what you have drawn. Checks to see if each has blackjack or a ace and is over 21
  def first_hand
    @player_hand = deck.cards.pop(2)
    @dealer_hand = deck.cards.pop(2)
    puts "Welcome to the table, today we're going to play Blackjack..Press any key."
    #Dumb speech, might take out.
    %x(say 'Hope your ready')
    gets
    puts "House will now deal you two cards..Press any key."
    #Dumb speech, might take out.
    %x(say 'to lose')
    gets
    if dealer_score == 21
      puts "Well you lost, I got #{dealer_score} already. That was quick huh."
      dealer_win
      play_again
    elsif player1_score == 21
      puts "You win. with a total of #{player1_score}. I didn't even get to deal :("
      player_win
      play_again
      #Not sure if this works, checks and sees if the player1_score is above 22 and is containing a ace and lets you change it to one.
      if player1_score == 22 && cards.value == 11
        puts "Would you like for Ace to equal 1? Yes or No"
        userinput == gets.chomp.downcase
      elsif userinput == "yes"
        player1_score - 10
      elsif userinput == "no"
        puts "You busted."
        play_again
      else
        puts "You must pick a a number."
      end
    end
    #Shows the first two cards you receive
    puts "Dealer showing #{dealer_hand[0].face} of #{dealer_hand[0].suit}."
    puts "You have a #{player_hand[0].face} of #{player_hand[0].suit} and a #{player_hand[1].face} of #{player_hand[1].suit}. "
  end
  #Starts off the game logic and checks to see if your cards are below 21. If they are it goes through the if else and figures out if you win or lose.
  def play
    if player1_score < 21
      puts "Would you like to Hit or Stay.."
      userinput = gets.chomp.downcase
      until userinput != "hit" || player1_score >= 21
        player_hit
        if player1_score == 21
          puts "Blackjack!! You win!!"
          player_win
          play_again
        elsif player1_score > 21
          dealer_win
          puts "Your total was #{player1_score}"
          puts "You Busted..sad face.."
          play_again
        elsif player1_score < 21
          puts "Your new total is #{player1_score}."
          play
        elsif player_hand > 6 && player1_score < 21
          puts "Somehow you achieved this, I'll let you have this win.."
          play_again
          dealer_win
        else
          wrong
        end
        wrong
      end
      if userinput == "stay"
        stay
      end
      wrong
    end
  end
  #pops another card from the deck when this method is called
  def player_hit
    player_hand << deck.cards.pop
    puts "you drew a #{player_hand.last.face} of #{player_hand.last.suit}."
  end
  #same as player_hit but for dealer
  def dealer_hit
    dealer_hand << deck.cards.pop
    puts "Dealer pulled a #{dealer_hand.last.face} of #{dealer_hand.last.suit}."
  end
  #Totals up the value of each card to get the sum value for player.
  def player1_score
    player_hand.inject(0){|sum,n| sum + n.value }
  end
  #same as player1_score but for dealer
  def dealer_score
    dealer_hand.inject(0){|sum,n| sum + n.value }
  end
  #Gives the player counter a +1 to the win column when this method is called.
  def player_win
    @player_win += 1
  end
  #Does the same as player win but for dealer.
  def dealer_win
    @dealer_win += 1
  end
  #when userinput "stay" is selected and checks to see if dealer is under 15. Then gives dealer another card. It proceeds to go through game logic to see if he wins or loses.
  def stay
    until dealer_score > 15 && player1_score
      dealer_hit
    end
    if dealer_score == 21
      puts "So sorry..dealer wins!! with a total of #{dealer_score}."
      player_win
      play_again
    elsif dealer_score > 21
      puts "Congrats..dealer busts!! with a total of #{dealer_score}."
      player_win
      play_again
    elsif dealer_score > player1_score
      puts "So sorry..dealer wins!! with a total of #{dealer_score}."
      dealer_win
      play_again
    elsif player1_score >= dealer_score
      puts "Congrats..you win!! with a score of #{player1_score} against dealers total of #{dealer_score}."
      player_win
      play_again
    end
  end
  #method for wrong inputs
  def wrong
    puts "I'm sorry you need to pick one of the two options."
    play
  end
  #Outputs how many times each player has won and ask if you would like to play again callling on the play_again method. If no it exits the game.
  def play_again
    player_win = @player_win
    dealer_win = @dealer_win
    puts "Player has won a total of #{player_win} and Dealer has won a total of #{dealer_win}."
    puts "Would you like to play again? Yes or No.."
    userinput = gets.chomp.downcase
    if userinput == "yes"
      first_hand
      play
    elsif userinput == "no"
      %x(say 'Goodbye')
      exit
    else
      puts "Sorry I didn't understand your input.."
      play_again
    end
  end
end

game = Game.new
game.play

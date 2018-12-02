require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Menu

  def initialize
    puts "Добро пожаловать в игру Black Jack ver.TN!"
    @deck = Deck.new
    @player = Player.new(get_name)
    @dealer = Dealer.new("Dealer")
    new_game
  end
  
  def get_name
    print "Введите ваше имя: "
    name = gets.chomp.to_s
  end

  def new_game
    @deck.shuffle_deck
    2.times { take_card(@player) }
    2.times { take_card(@dealer) }
    see_hand(@player)
    see_hand(@dealer)
    see_score
    @player.place_bet
    @dealer.place_bet
    user_move
  end

  def take_card(name)
    card = @deck.give_card
    name.take_card(card)
  end

  def see_hand(obj)
    return puts "Карт в руке диллера: #{'*' * obj.hand.size}." if obj.name == "Dealer"
    
    cards = []
    obj.hand.each { |card| cards << [card.val + card.suit] }
    puts "#{obj.name}, у вас в руке: #{cards.join(", ")}."
  end

  def see_score
    puts "Incoming....."
  end

  def user_move
    puts "Incoming....."
  end
end

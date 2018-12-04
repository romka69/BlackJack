require_relative 'interface'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Menu
  def initialize
    @interface = Interface.new
    @interface.hello_message
    @deck = Deck.new
    @player = Player.new(@interface.input_name)
    @dealer = Dealer.new("Dealer")
    new_game
  end

  def new_game
    @interface.round_message
    @deck.shuffle_deck
    2.times { take_card(@player) }
    2.times { take_card(@dealer) }
    see_hand(@player)
    see_hand(@dealer)
    @player.count_score
    @dealer.count_score
    see_score(@player)
    @player.place_bet
    @dealer.place_bet
    user_move
  end

  def take_card(name)
    card = @deck.give_card
    name.take_card(card)
  end

  def see_hand(person, open = false)
    return @interface.see_hand_crypto(@dealer.name, @dealer.hand.cards.size) if person.name == "Dealer" && open == false

    @interface.see_hand(person.name, person.see_cards)
  end

  def see_score(person)
    @interface.see_score(person.name, person.score)
  end

  def user_move
    loop do
      choise = @interface.user_move_menu(@player.name, @player.add_card?)

      case choise
      when 1
        open_cards
      when 2
        dealer_move if @player.add_card?
      when 3
        add_card if @player.add_card?
      else
        @interface.wrong_number_menu
      end
    end
  end

  def dealer_move
    if @dealer.add_card?
      take_card(@dealer)
      @dealer.count_score
      see_hand(@dealer)
      user_move
    end

    see_hand(@dealer)
    user_move
  end

  def add_card
    return unless @player.add_card?

    take_card(@player)
    @player.count_score
    see_hand(@player)
    dealer_move
  end

  def open_cards
    see_hand(@dealer, true)
    see_score(@dealer)
    see_hand(@player)
    see_score(@player)
    discover_winner
  end

  def discover_winner
    if @player.score > @dealer.score && @player.good_score?
      @player.take_win_bet
      @interface.see_winner(@player.name, @player.bank.quantity)
    elsif @dealer.score > @player.score && @dealer.good_score?
      @dealer.take_win_bet
      @interface.see_winner(@dealer.name, @dealer.bank.quantity)
    elsif @player.score == @dealer.score && @player.good_score?
      @player.bet_back
      @dealer.bet_back
      @interface.see_draw
    else
      @interface.see_two_loosers
    end

    next_round
  end

  def next_round
    return empty_bank if @player.bank.quantity.zero? || @dealer.bank.quantity.zero?

    loop do
      choice = @interface.next_game_menu(@player.name)

      case choice
      when 1 then new_round
      when 2 then exit
      else
        @interface.wrong_number_menu
      end
    end
  end

  def empty_bank
    if @player.bank.quantity.zero?
      looser = @player.name
    else
      looser = @dealer.name
    end

    @interface.see_looser(looser)
    exit
  end

  def new_round
    @player.clear_hand
    @dealer.clear_hand
    new_game
  end
end

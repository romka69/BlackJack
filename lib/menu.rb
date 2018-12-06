require_relative 'interface'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Menu
  def initialize
    @interface = Interface.new
    @interface.hello_message

    begin
      @player = Player.new(@interface.input_name)
    rescue StandardError => e
      puts e
      retry
    end

    @dealer = Dealer.new("Dealer")
    new_game
  end

  def new_game
    loop do
      preparating_new_game

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
  end

  def preparating_new_game
    @deck = Deck.new
    @next_round = false
    @interface.round_message
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
      break if @next_round

      choise = @interface.user_move_menu(@player.name, @player.hand.cards.size < 3)

      case choise
      when 1
        open_cards
      when 2
        dealer_move if @player.hand.cards.size < 3
      when 3
        add_card if @player.hand.cards.size < 3
      else
        @interface.wrong_number_menu
      end
    end
  end

  def dealer_move
    if @dealer.hand.cards.size < 3
      take_card(@dealer)
      @dealer.count_score
    end

    see_hand(@dealer)
  end

  def add_card
    return unless @player.hand.cards.size < 3

    take_card(@player)
    @player.count_score
    see_hand(@player)
  end

  def open_cards
    see_hand(@dealer, true)
    see_score(@dealer)
    see_hand(@player)
    see_score(@player)
    search_winner
    next_round
  end

  def search_winner
    winner = discover_winner

    case winner
    when :no_winner
      @interface.see_two_loosers
    when :draw
      @player.bet_back
      @dealer.bet_back
      @interface.see_draw
    when :player
      @player.take_win_bet
      @interface.see_winner(@player.name, @player.bank.quantity)
    when :dealer
      @dealer.take_win_bet
      @interface.see_winner(@dealer.name, @dealer.bank.quantity)
    end
  end

  def discover_winner
    return :no_winner unless @player.good_score? && @dealer.good_score?

    return :draw if @player.score == @dealer.score

    return :player if @player.score > @dealer.score && @player.good_score?

    return :dealer if @dealer.score > @player.score && @dealer.good_score?

    return :dealer unless @player.good_score?

    return :player unless dealer.good_score?
  end

  def next_round
    return empty_bank if @player.bank.quantity.zero? || @dealer.bank.quantity.zero?

    choice = @interface.next_game_menu(@player.name)

    case choice
    when 1
      @player.clear_hand
      @dealer.clear_hand
      @next_round = true
    else
      exit
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
end

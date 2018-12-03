require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Menu
  def initialize
    puts "Добро пожаловать в игру Black Jack ver.TN!"
    @deck = Deck.new
    @player = Player.new(input_name)
    @dealer = Dealer.new("Dealer")
    new_game
  end

  def input_name
    print "Введите ваше имя: "
    name = gets.chomp.to_s.capitalize
    name
  rescue StandartError => e
    puts e
    retry
  end

  def new_game
    @deck.shuffle_deck
    2.times { take_card(@player) }
    2.times { take_card(@dealer) }
    see_hand(@player)
    see_hand(@dealer)
    count_score(@player)
    count_score(@dealer)
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
    return puts "В руке '#{@dealer.name}': #{'*' * person.hand.size}." if person.name == "Dealer" && open == false

    cards = []
    person.hand.each { |card| cards << [card.val + card.suit] }
    puts "В руке '#{person.name}': #{cards.join(', ')}."
  end

  def count_score(person)
    score = []
    ace = false

    person.hand.each do |card|
      score << card.score_card.to_i
      ace = true if card.ace?
    end

    person_score = score.sum
    person_score -= 10 if ace && score.sum > 21
    person.score = person_score
  end

  def see_score(person)
    puts "Очки '#{person.name}': #{person.score}."
  end

  def user_move
    loop do
      puts "#{@player.name}, ваш ход:"
      puts "1. Открыть карты"
      puts "2. Пропустить ход" if @player.add_card?
      puts "3. Добавить карту" if @player.add_card?

      choise = gets.chomp.to_i

      case choise
      when 1 then open_cards
      when 2
        dealer_move if @player.add_card?
      when 3
        add_card if @player.add_card?
      else
        puts "Введите число согласно меню!"
      end
    end
  end

  def dealer_move
    if @dealer.add_card?
      take_card(@dealer)
      count_score(@dealer)
      see_hand(@dealer)
      user_move
    end

    see_hand(@dealer)
    user_move
  end

  def add_card
    return unless @player.add_card?

    take_card(@player)
    count_score(@player)
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
    if !@player.good_score?
      @dealer.take_win_bet
      puts_winner(@dealer)
    elsif @player.score > @dealer.score && @player.good_score?
      @player.take_win_bet
      puts_winner(@player)
    elsif @dealer.score > @player.score && @dealer.good_score?
      @dealer.take_win_bet
      puts_winner(@dealer)
    elsif @player.score == @dealer.score && @player.good_score?
      @player.bet_back
      @dealer.bet_back
      puts "Ничья."
    else
      puts "Игрок и дилер проиграли."
    end

    next_round
  end

  def puts_winner(person)
    puts "'#{person.name}' победил в этом раунде, банк составляет '#{person.bank.quantity}'."
  end

  def next_round
    return empty_bank if @player.bank.quantity.zero? || @dealer.bank.quantity.zero?

    loop do
      puts "
#{@player.name}, сыграем еще?
1. Да
2. Нет/Выход из игры
"
      choice = gets.chomp.to_i

      case choice
      when 1 then new_round
      when 2 then exit
      else
        puts "Введите число согласно меню!"
      end
    end
  end

  def empty_bank
    if @player.bank.quantity.zero?
      looser = @player.name
    else
      looser = @dealer.name
    end

    puts "У '#{looser}' закончились деньги. Выход из игры."
    exit
  end

  def new_round
    @player.clear_hand
    @dealer.clear_hand
    new_game
  end
end

class Interface
  def hello_message
    print line
    puts "Добро пожаловать в игру Black Jack ver.TN!"
    print line
  end

  def input_name
    print "Введите ваше имя: "
    gets.chomp.to_s.capitalize
  end

  def round_message
    puts ""
    puts "----- Начало раунда -----"
  end

  def see_hand_crypto(name, size)
    puts "В руке '#{name}': #{'*' * size}."
  end

  def see_score(name, score)
    puts "Очки '#{name}': #{score}."
  end

  def see_hand(name, cards)
    puts "В руке '#{name}': #{cards}."
  end

  def user_move_menu(name, add_card = false)
    puts ""
    puts "----- #{name}, ваш ход: -----"
    puts "Введите число согласно меню:"
    puts "1. Добавить карту"
    puts "Любой символ - Не добавлять" if add_card
    puts "2. Пропустить ход" unless add_card
    puts "3. Открыть карты" unless add_card
    gets.chomp.to_i
  end

  def next_game_menu(name)
    puts ""
    puts "----- #{name}, сыграем еще? -----"
    puts "Введите согласно меню:"
    puts "1. Да"
    puts "Любой символ - Нет/Выход из игры"
    gets.chomp.to_i
  end

  def wrong_number_menu
    puts "!!! Введите число согласно меню !!!"
  end

  def card_add_in_hand(name)
    puts ""
    puts "----- '#{name}' взял еще одну карту. -----"
    puts ""
  end

  def dealer_not_take_card(name)
    puts ""
    puts "----- '#{name}' не стал брать карту -----"
    puts ""
  end

  def open_cards
    puts ""
    puts "----- Открываем карты -----"
  end

  def see_winner(name, bank)
    puts ""
    print line
    puts "'#{name}' победил в этом раунде, банк составляет '#{bank}'."
    print line
  end

  def see_draw
    print line
    puts "----- Ничья -----"
    print line
  end

  def see_two_loosers
    print line
    puts "----- Игрок и дилер проиграли -----"
    print line
  end

  def see_looser(name)
    print line
    puts "----- '#{name}' ПРОИГРАЛ, закончились деньги. Выход из игры -----"
    print line
  end

  def line
    puts "------------------------------------------"
  end
end

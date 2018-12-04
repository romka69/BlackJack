class Interface
  def hello_message
    puts "Добро пожаловать в игру Black Jack ver.TN!"
  end

  def input_name
    print "Введите ваше имя: "
    gets.chomp.to_s.capitalize
  end

  def round_message
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

  def user_move_menu(name, add_card)
    puts "----- #{name}, ваш ход: -----"
    puts "Введите число согласно меню:"
    puts "1. Открыть карты"
    puts "2. Пропустить ход" if add_card
    puts "3. Добавить карту" if add_card
    gets.chomp.to_i
  end

  def wrong_number_menu
    puts "!!!Введите число согласно меню!!!"
  end

  def see_winner(name, bank)
    puts line
    puts "'#{name}' победил в этом раунде, банк составляет '#{bank}'."
  end

  def see_draw
    puts "----- Ничья -----"
  end

  def see_two_loosers
    puts "----- Игрок и дилер проиграли -----"
  end

  def next_game_menu(name)
    puts "----- #{name}, сыграем еще? -----"
    puts "1. Да"
    puts "2. Нет/Выход из игры"
    gets.chomp.to_i
  end

  def see_looser(name)
    puts "----- '#{name}' ПРОИГРАЛ, закончились деньги. Выход из игры -----"
  end

  def line
    puts "----------"
  end
end

class BoardCase # classe dont chaque instance est une case du plateau de jeu
  attr_accessor :case_value, :case_number
  def initialize(written, number)
    @case_value = written
    @case_number = number
  end
  def return_value
    return @case_value.to_s
  end
end
class Board     # classe du plateau de jeu, organise l'affichage du tableau, modifie les instances BoardCase, vérifie les conditions de victoire
  attr_accessor :board_array
  def initialize
    @case_1 = BoardCase.new(" ", 1)
    @case_2 = BoardCase.new(" ", 2)
    @case_3 = BoardCase.new(" ", 3)
    @case_4 = BoardCase.new(" ", 4)
    @case_5 = BoardCase.new(" ", 5)
    @case_6 = BoardCase.new(" ", 6)
    @case_7 = BoardCase.new(" ", 7)
    @case_8 = BoardCase.new(" ", 8)
    @case_9 = BoardCase.new(" ", 9)
    @board_array = [@case_1, @case_2, @case_3, @case_4, @case_5, @case_6, @case_7, @case_8, @case_9]
  end
  def display                      # méthode pour l'affichage du plateau dans le terminal
    puts "           #{@board_array[0].return_value} | #{@board_array[1].return_value} | #{@board_array[2].return_value} "
    puts "          ---|---|---"
    puts "           #{@board_array[3].return_value} | #{@board_array[4].return_value} | #{@board_array[5].return_value} "
    puts "          ---|---|---"
    puts "           #{@board_array[6].return_value} | #{@board_array[7].return_value} | #{@board_array[8].return_value} "
  end
  def play(case_sign)              # méthode pour sélectionner et cocher une case
    loop do chosen_case = gets.to_i
      if chosen_case < 10 && chosen_case > 0 && @board_array[chosen_case-1].return_value == " "
        @board_array[chosen_case-1] = BoardCase.new(case_sign, chosen_case)
        break
      else
        puts "Bad entry, please try again."
        puts "Try a number between 1 and 9 that hasn't been played yet."
      end
    end
  end
  def victory?(signs, player_name) # méthode pour vérifier si les conditions de victoire sont atteintes
    if @board_array[0].return_value == signs && @board_array[1].return_value == signs && @board_array[2].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[3].return_value == signs && @board_array[4].return_value == signs && @board_array[5].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[6].return_value == signs && @board_array[7].return_value == signs && @board_array[8].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[0].return_value == signs && @board_array[3].return_value == signs && @board_array[6].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[1].return_value == signs && @board_array[4].return_value == signs && @board_array[7].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[2].return_value == signs && @board_array[5].return_value == signs && @board_array[8].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[0].return_value == signs && @board_array[4].return_value == signs && @board_array[8].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    elsif @board_array[2].return_value == signs && @board_array[4].return_value == signs && @board_array[6].return_value == signs
      puts
      puts "#{player_name} has won !"
      return 1
    else
      return 0
    end

  end
end
class Player    # classe dont chaque instance est un joueur
  attr_accessor :player_name
  def initialize(symbol)
    puts "Enter name for #{symbol} player :"
    @player_name = gets.chomp
  end
end
class Game      # classe du jeu qui affiche les instructions, permet de lancer le jeu, créé les joueurs, effectue les tours, demande à rejouer
  def initialize
    again = 0
    @win_one = 0
    @win_two = 0
    @games_played = 0
    welcome
    @player_one = Player.new("X")
    @player_two = Player.new("O")
    loop do
      system('clear')
      if again == 0

        @game_board = Board.new
        @victory = 0
        if @games_played > 0
          puts "So far, you've played #{@games_played} games."
          puts "#{@player_one.player_name} has won #{@win_one} games and #{@player_two.player_name} has won #{@win_two} games."
          puts "Get ready for the next round."
        else
          puts "Hello, #{@player_one.player_name} and #{@player_two.player_name}. Welcome to tic tac toe. Game will start soon."
        end
        sleep(3)
        go # METHODE LANCANT LE JEU
        puts
        sleep(2)
        loop do puts "Play again ? [Y/N]" # REPETEUR : permet de lire le programme en boucle
          choice = gets.chomp
          if choice == "y" || choice == "Y"
            break
          elsif choice == "n" || choice == "N"
            again += 1 # permet d'arrêter la boucle du programme
            break
          else
            puts "Wrong entry, try again"
          end
        end
      else
        break
      end
    end
  end
  def go                          # méthode pour lancer la partie, vérifier qui doit jouer, et lancer la vérification de victoire
    c = 0
    system('clear')
    @game_board.display
    loop do
      if @victory == 1
        @games_played += 1
        break
      elsif c == 9
        puts
        puts "It's a tie."
        @games_played += 1
        break
      elsif c.even? == true && c <= 9 && @victory != 1
        turn(@player_one, "X")
        c += 1
        @victory += @game_board.victory?("X", @player_one.player_name)
        if @victory == 1
          @win_one += 1
        else
        end
      elsif c.even? == false && c <= 9 && @victory != 1
        turn(@player_two, "O")
        c += 1
        @victory += @game_board.victory?("O", @player_two.player_name)
        if @victory == 1
          @win_two += 1
        else
        end
      end
    end
  end
  def turn(player, current_sign)  # méthode pour afficher les instructions de tour, et sélectionner et cocher une case
    puts
    puts "#{player.player_name}, you play as #{current_sign}, and it's your turn to play."
    puts
    puts "Put a number between 1 and 9 and press enter based on the display below."
    puts
    puts "[1][2][3]"
    puts "[4][5][6]"
    puts "[7][8][9]"
    puts
    @game_board.play(current_sign)
    system('clear')
    @game_board.display
  end
  def welcome                     # (SECONDAIRE) méthode d'instructions lancée au début du programme
    system('clear')
    puts "888    d8b            888                         888"
    sleep(0.10)
    puts "888    Y8P            888                         888"
    sleep(0.10)
    puts "888                   888                         888"
    sleep(0.10)
    puts "888888 888  .d8888    b888888  8888b.   .d8888    b888888   .d88b.    .d88b."
    sleep(0.10)
    puts "888    888 d88P       888        88bd 88P         888     d88  88b  d8P  Y8b"
    sleep(0.10)
    puts "888    888 888        888    .d888888 888         888     888  888  88888888"
    sleep(0.10)
    puts "Y88b.  888 Y88b.      Y88b.  888  888 Y88b.       Y88b.   Y88..88P  Y8b."
    sleep(0.10)
    puts "  Y888 888  Y8888P      Y888  Y888888   Y8888P      Y888    Y88P      Y8888"
    sleep(1.5)
    puts
    puts
    puts
    puts "Welcome to tic tac toe, the game."
    sleep(3)
    puts "This game is intended for two players."
    sleep(2)
    puts "One will be playing the Xs, the other will be playing the Os."
    sleep(2)
    puts "Each one of you will put a X or a O in one of the nine cases."
    puts "First player to put three of his own signs in a line (vertically, horizontally, or diagonally) wins the game."
    sleep(2)
    puts
    sleep(3)
    puts 'Press ENTER to play.'
    gets
    system('clear')
  end
end
Game.new # créé une instance session de la classe Game

=begin
Recette pour un Jafar
4cl de rhum ambre ( Pensez Dark Rum, comme un Kraken, par exemple )
8cl de jus d'ananas
2cl de sirop de grenadine
Versez dans un verre long le rhum ambre avec le jus d'ananas.
Ajoutez lentement le sirop de grenadine pour qu'il se depose au fond du verre.
Degustez
=end

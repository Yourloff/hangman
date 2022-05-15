class ConsoleInterface
  FIGURES = Dir[__dir__ + '/../data/figures/*.txt'].
    sort.
    map{ |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show.colorize(:light_blue)}
      #{figure}
    END
    puts ColorizedString["Ошибки (#{@game.errors_made}): #{errors_to_show}"].colorize(:red)
    puts ColorizedString["У вас осталось ошибок: #{@game.errors_allowed}"].colorize(:light_green)

    if @game.won?
      puts 'Вы выиграли!'.colorize(:light_white)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}".colorize(:light_white)
    end
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter.nil?
          '__'
        else
          letter
        end
      end
    result.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def figure
    FIGURES[@game.errors_made].colorize(:light_magenta)
  end

  def get_input
    print 'Введите следующую букву: '
    STDIN.gets[0].chomp.upcase
  end

end

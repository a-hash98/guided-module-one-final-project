require 'tty-prompt'
require 'pry'

class CLI


  def initialize
    @prompt = TTY::Prompt.new
  end

  #gameplay-based prompt methods

  def create_account_option
    input = @prompt.keypress('Welcome! Press A register an account, B to sign in, or X to exist the platform.')
    return input
  end

  def unique_details?(username)
    return false if User.find_by(username: username) != nil
    return true if User.find_by(username: username) == nil
  end



  def create_account_or_sign_in
    input = create_account_option
    if input == 'A'
      username = @prompt.ask('Enter a username to register with.')

        while !unique_details?(username)
          puts 'Username taken. Please enter a different one.'
          username = @prompt.ask('Enter a username to register with.')
          unique_details?(username)
       end

      password = @prompt.ask('Enter a password.')
      @user = User.register_account(username,password)
      puts 'You have now successfully registered!'

    elsif  input=='B'
      username = @prompt.ask('Enter your username.')

      @user = User.find_by(username: username)
      if @user == nil
        puts 'Invalid username or password. Please register a different one.'
        username = @prompt.ask('Enter a username to register with.')
        password = @prompt.ask('Enter a password.')
        while !unique_details?(username)
          puts 'Username taken. Please enter a different one.'
          username = @prompt.ask('Enter a username to register with.')
          password = @prompt.ask('Enter a password.')
          unique_details?(username)
       end
        @user = User.register_account(username,password)
        puts 'You have now successfully registered, and logged in!'
      else
        password = @prompt.ask('Enter your password.')
        puts 'You have now logged in!'
      end

   elsif input=='X'
      exit
   else
      create_account_option
  end
end

  def choose_genre
    choices = ['countries','British desserts','rocks and minerals ']
    @genre = @prompt.enum_select("Welcome to Hangman! Select genre:", choices)
  end


  def instantiate_gameplay_based_on_genre
    puts 'The game will now begin:'
    #get all game records corresponding to the genre
    input = @genre
    game = Game.where(genre: input).sample
    #create new gameplay object to store the stats
    gameplay = GamePlay.create(result: false,user_id: @user.id, game_id: game.id)
    #start the actual game
    positions = Game.hide_word_letter_positions(game.word)
    attempts = Game.calculate_attempts(positions)
    #transformed_word = Game.hide_word_letters(game.word).to_s
    updated_word = Game.hide_word_letters(game.word).to_s
    puts ' * * * * * * * * * * * * * * * * * * * * * * * * * * *'
    while attempts > 0
      puts 'Enter letter'
      input = gets.chomp.to_s
      updated_word = Game.update_letters(game.word.to_s,input,updated_word)
      attempts -= 1
      if Game.won?(updated_word,game.word.to_s,attempts)
        puts "Congrats - you've won!"
        break
      end
      if attempts == 0
        puts "Sorry, no more attempts left! The correct word was: #{game.word.to_s}"
        break
      end
   end




    #end
    #if !Game.attempts_left?
    #  puts 'No more attempts left.'
    #end

  end




  def update_game_result
    ###when game finishes, update win column in GamePlay object
  end


  def diplay_wins_losses_as_percentage
  end

  def display_most_frequently_played_genre
  end

  def display_last_played_genre
  end

  def display_time_of_last_played_by_genre
  end

  #user-based methods
  def display_last_played_game_details?
    @prompt.yes?("Would you like to view details of the last game you played?")
  end

  def display_last_played_game_details
    if display_last_played_game_details?
      puts "Here are the stats for your last played game:"
      puts "Name: #{@user.gameplays.last.name}"
      puts "Result: #{@user.gameplays.last.result}"
      puts "Date/Time of play: #{@user.gameplays.last.played_at}"
   end
  end

  def display_all_gameplay_details?
    @prompt.yes?("Would you like to view details of all the games you've played?")
  end

  def display_all_gameplay_details

      if display_all_gameplay_details
        puts "Here are the stats for all your games:"
        @user.gameplays.each do |gameplay|
        puts "Name: #{gameplay.name}"
        puts "Result: #{gameplay.result}"
        puts "Date/Time of play: #{gameplay.played_at}"
      end
     end

  end

  def percentage_of_wins_losses?
    @prompt.yes?("Would you like to view your wins and losses?")
  end

  def percentage_of_wins_losses

      if percentage_of_wins_losses?
        puts "Here are your wins/losses:"
        @user.gameplays.each do |gameplay|
        puts "Name: #{gameplay.name}"
        puts "Result: #{gameplay.played_at}"
      end
     end

  end


  def display_most_played_genre?
    @prompt.yes?("Would you like to view your most played genre?")
  end

  def display_most_played_genre
    ####
  end

  def display_least_played_genre?
     @prompt.yes?("Would you like to view your least played genre?")
  end

  def display_least_played_genre
     ######
  end

 def display_user_rank?
   @prompt.yes?("Would you like to display your rank on the leaderboard?")
 end

 def display_user_rank
   ####
 end

 def win_message
   puts "Congratulations, you won the game!"
 end

 def lose_message
   puts "Sorry, try next time!"
 end

 def play_again?
   play_again=@prompt.ask("Would like to play again?")
   play_again
 end

 def run
   create_account_or_sign_in
   choose_genre
   #Game.update_letters('Banoffee pie','e','Banoff__ pi_')
   instantiate_gameplay_based_on_genre
  #retrieve_all_genres
  #create_account_or_sign_in
  #choose_genre
 end

end

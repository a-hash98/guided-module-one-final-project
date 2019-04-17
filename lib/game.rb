#require 'rest_client'
#require 'JSON'

class Game < ActiveRecord::Base
  has_many :gamesplays
  has_many :users, through: :gameplays

  def select_random_word(name:,genre:)
    genres['genre_name'].sample.to_s
  end

  def display_random_word
    puts select_random_word
  end

  def self.hide_word_letters(word)
    transform_word = word.split('')
    positions = hide_word_letter_positions(word)
    positions.map{|ind| transform_word[ind] = '-' }
    transform_word = transform_word.join('')
    puts transform_word
    transform_word
  end

  def self.hide_word_letter_positions(word)
    positions_to_hide=[]
    len=word.length
    num_to_hide=len/2.floor
    num_to_hide.times do
      positions_to_hide.push(rand(len))
    end
    positions_to_hide
  end

  def self.update_letters(w,l,w_to_update)
    if !w.include?(l)
      return w_to_update
    end
    #puts w_to_update
    word = w.chars
    word_to_update = w_to_update.chars

    positions = []
    word.length.times {|pos| positions << pos if w[pos,1] == l}
    #puts positions
    # swap out for-loop?

    positions.each do |index|
      word_to_update[index] = l
    end
    puts word_to_update.join('')
    return word_to_update.join('')
  end

  def self.won?(original_word,word_to_update,attempts)
    return false if attempts == 0
    return true if original_word == word_to_update
  end

  def self.calculate_attempts(positions_to_hide)
    @attempts = 0
    @attempts = positions_to_hide.length + 2 if positions_to_hide.length <= 5
    @attempts = positions_to_hide.length + 4 if positions_to_hide.length <=8
    @attempts = positions_to_hide.length + 6 if positions_to_hide.length <=15
    return @attempts
  end


#memory game commands - ignore all below

  sequence_elements = []
  sequence = []

  def generate_sequence(num=3,sequence_elements,sequence)
    num.times do
      sequence.push(sequence_elements.sample)
    end
  end

   def flash_sequence(sequence)
      for i in sequence
        puts i
        sleep 2
      end
   end

  def increment_sequence(sequence)
      generate_sequence(num=num+1,sequence_elements,sequence)
  end

  def decrement_sequence(sequence)
    decrement_sequence(num=num-1,sequence_elements,sequence)
  end

  def user_input(sequence)
    user_input = []
    i = 0
    sequence.times do
      user_input.push(gets.chomp)
    end
    user_input
  end

  def evaluate_user_input(sequence)
    return true if user_input(sequence) == sequence
    return false
  end

  def next_round(sequence)
    increment_sequence(sequence) if evaluate_user_input(sequence)
    decrement_sequence(sequence) if !evaluate_user_input(sequence)
  end

  def start_next_round(sequence)
    next_round(sequence)
    flash_sequence(sequence)
    user_input(sequence)
  end

end

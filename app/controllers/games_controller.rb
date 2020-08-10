require 'open-uri'

class GamesController < ApplicationController

  def new
    @new_array = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    attempt = params[:guess]
    @message = ""
    if included?(attempt.upcase)
      if english_word?(attempt)
        @message = "well done!"
      else
        @message = "not an english word"
      end
    else
      @message = "Sorry but #{attempt} can't be built out of #{@new_array}"
    end
  end

  def english_word?(attempt)
    response = open("https://wagon-dictionary.herokuapp.com/#{attempt}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?(attempt)
    attempt.chars.all? { |letter| attempt.count(letter) <= 10 }
  end


end



















# def generate_grid(grid_size)
#   Array.new(grid_size) { ('A'..'Z').to_a.sample }
# end



# def compute_score(attempt, time_taken)
#   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
# end

# def run_game(attempt, grid, start_time, end_time)
#   result = { time: end_time - start_time }

#   score_and_message = score_and_message(attempt, grid, result[:time])
#   result[:score] = score_and_message.first
#   result[:message] = score_and_message.last

#   result
# end

# def score_and_message(attempt, grid, time)
#   if included?(attempt.upcase, grid)
#     if english_word?(attempt)
#       score = compute_score(attempt, time)
#       [score, "well done"]
#     else
#       [0, "not an english word"]
#     end
#   else
#     [0, "not in the grid"]
#   end
# end

# def english_word?(word)
#   response = open("https://wagon-dictionary.herokuapp.com/#{word}")
#   json = JSON.parse(response.read)
#   return json['found']
# end

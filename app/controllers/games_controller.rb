require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(("A".."Z").to_a.sample)}
    @letters
  end

  def score
    @letters = params[:letters]
    @hash_attempt = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{params[:score]}").read)
    @array_attempt = @hash_attempt["word"].upcase.chars
    if @hash_attempt["found"] == false
    @result = "Sorry but #{params[:score]}is not an english word"
    elsif (@array_attempt.all? { |i| @letters.count(i) >= @array_attempt.count(i) }) == false
    @result = "Sorry but #{params[:score].upcase}can't be build of #{@letters.join(",")}"
    else
    @result = "Congratulations!#{params[:score].upcase} is a valid english word!"
    end

  end
end

require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request

  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def get_movie_titles(character_name)
  if get_character_movies_from_api(character_name)["results"].map {|character_hash| character_hash["name"].downcase}.include?(character_name)
    characters_movies = get_character_movies_from_api(character_name)["results"].find {|character_hash| character_hash["name"].downcase == character_name}["films"]
    characters_movies.map do |movie|
      movie_response_string = RestClient.get(movie)
      movie_response_hash = JSON.parse(movie_response_string)
    end.map {|movie_hash| movie_hash["title"]}
  else
    "No info"
  end
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  puts
  puts "That character appears in the following films:"
  puts
  films.each { |film| puts film }
  puts
end

def show_character_movies(character)
  films = get_movie_titles(character)
  if films == "No info"
    puts
    puts "Sorry, we don't have any information for that character--check back soon!"
    puts
  else
    print_movies(films)
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

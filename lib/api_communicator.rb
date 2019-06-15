require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  results_hash = response_hash["results"]
  films_array = []
  results_hash.each do |creature|
    if creature["name"].downcase == character_name
      films_array = creature["films"]
    end
  end
  yes = films_array.map { |film| JSON.parse(RestClient.get(film)) }
  
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

def print_movies(films)
  puts films
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  film_hash = {}
  films = get_character_movies_from_api(character).map { |film| film_hash[film["title"]] = film["release_date"][0..3] }
  print_movies(film_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

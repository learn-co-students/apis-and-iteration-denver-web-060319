require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  film_array = []
  response_hash["results"].each do | name_hash |
    if name_hash["name"] == character_name
     name_hash["films"].each do | film |
      film_string = RestClient.get(film)
      character_hash = JSON.parse(film_string)
      film_array << character_hash
      end
    end
  end
 film_array
end 

def print_movies(films)
  title_array = []
  films.each do | movie_hashes |
    title_array << movie_hashes["title"]
  end
    title_array.each_with_index do | title, index |
      puts "#{index + 1} #{title}"
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

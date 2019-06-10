require 'rest-client'
require 'json'
require 'pry'

def get_api_info
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  response_hash["results"]
end

def get_character_movies_from_api(character_name)
  characters = get_api_info
  film_info = []
  characters.each do |character|
    if character["name"].downcase == character_name
      character["films"].each do |website|
        website_response = RestClient.get(website)
        film_info << JSON.parse(website_response)
      end
    end
  end
  film_info
end

def print_characters
  characters = get_api_info
  puts "-------------------"
  characters.each {|characters| puts characters["name"] }
  puts "-------------------"
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  names = []
  films.each do |film|
    names << "Episode #{film["episode_id"]}. #{film["title"]}"
  end
  puts "----------------------------------"
  puts names.sort
  puts "----------------------------------"
end

def show_character_movies (character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

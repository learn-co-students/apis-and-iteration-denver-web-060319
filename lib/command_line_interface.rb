def welcome
  puts "Hello from Star Wars Fanatics -- Denver"
end

def get_character_from_user
  puts "please enter a character name"
  user_reponse = gets.chomp
  return user_reponse
  # use gets to capture the user's input. This method should return that input, downcased.
end

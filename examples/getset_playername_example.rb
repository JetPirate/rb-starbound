require 'rbstarbound'

# Change the path for your save file
path = '/home/Starbonud/my_save.player'

player_data = RBStarbound.parse_player_save_file(path)
player_data.player_name = 'NewName'

puts player_data.player_name

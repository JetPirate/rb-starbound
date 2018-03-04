require 'rbstarbound/version'
require 'rbstarbound/exceptions'
require 'rbstarbound/sbvj01'
require 'rbstarbound/sbon'

module RBStarbound
  def self.ping
    puts 'Pong!'
  end

  def self.parse_player_save_file(path)
    save_file = File.open(path, 'rb')
    parsed_data = SBVJ01.parse(save_file)
  rescue StandardError => e
    puts 'An error occured: ' + e.message.split(' @ ').first
  else
    return parsed_data
  ensure
    save_file.close unless save_file.nil?
  end
end

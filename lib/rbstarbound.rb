# frozen_string_literal: true

require 'rbstarbound/version'
require 'rbstarbound/exceptions'
require 'rbstarbound/utils'
require 'rbstarbound/sbvj01'
require 'rbstarbound/sbon'
require 'rbstarbound/sbasset6'
require 'rbstarbound/exit_codes'
require 'rbstarbound/main_command'

module RBStarbound
  def self.parse_player_save_file(path)
    save_file = File.open(path, 'rb')
    parsed_data = SBVJ01.parse(save_file)
  rescue StandardError => e
    print_error(e)
    return nil
  else
    return parsed_data
  ensure
    save_file.close unless save_file.nil?
  end

  def self.dump_player_save_file(path, player_data)
    save_file = File.open(path, 'wb')
    SBVJ01.dump(save_file, player_data)
  rescue StandardError => e
    print_error(e)
    return false
  else
    return true
  ensure
    save_file.close unless save_file.nil?
  end
end

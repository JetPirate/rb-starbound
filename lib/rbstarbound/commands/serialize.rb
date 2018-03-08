# frozen_string_literal: true

require 'yaml'

module RBStarbound
  class SerializeCommand < Clamp::Command
    option ['-f', '--format'], 'FORMAT', 'file\'s input format; one of: yaml',
           required: true
    option ['-i', '--formatted-file'], 'FILE',
           'file to fetch player data from',
           required: true
    option ['-o', '--save-file'], 'FILE', 'file to save player data to',
           required: true

    def execute
      return unless format.casecmp('yaml').zero?
      serialize_from_yaml(formatted_file.to_s, save_file.to_s)
    end

    private

    def serialize_from_yaml(input, output)
      formatted_file = File.open(input)
      fetched_data = YAML.load(formatted_file)
      player_data = RBStarbound::Player::Data.new(
        RBStarbound::Player::DATA_NAME,
        RBStarbound::Player::DATA_VERSION,
        fetched_data
      )
      dumped = RBStarbound.dump_player_save_file(output, player_data)
      return dumped ? RBStarbound::EX_OK : RBStarbound::EX_ERR
    rescue StandardError => e
      RBStarbound.print_error(e)
      return RBStarbound::EX_ERR
    ensure
      formatted_file.close unless formatted_file.nil?
    end
  end
end

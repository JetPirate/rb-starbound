# frozen_string_literal: true

module RBStarbound
  class DumpCommand < Clamp::Command
    option ['-f', '--format'], 'FORMAT', 'file\'s output format; one of: yaml',
           required: true
    option ['-i', '--save-file'], 'FILE',
           'file to fetch player data from',
           required: true
    option ['-o', '--formatted-file'], 'FILE', 'file to save player data to',
           required: true

    def execute
      return unless format.casecmp('yaml').zero?
      dump_to_yaml(save_file.to_s, formatted_file.to_s)
    end

    private

    def dump_to_yaml(input, output)
      player_data = RBStarbound.parse_player_save_file(input.to_s)
      return RBStarbound::EX_ERR if player_data.nil?
      begin
        formatted_file = File.open(output, 'w')
        formatted_file.write(player_data['data'].to_yaml)
        return RBStarbound::EX_OK
      rescue StandardError => e
        RBStarbound.print_error(e)
        return RBStarbound::EX_ERR
      ensure
        formatted_file.close unless formatted_file.nil?
      end
    end
  end
end

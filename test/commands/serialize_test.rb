# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '../test_helper')

class SerializeCommandTest < Minitest::Test
  def test_it_serializes_from_yaml
    cmd = RBStarbound::MainCommand.new('', {})
    file = Tempfile.new('serialize_cmd_test_temp')
    params = %w[serialize -f yaml -i] << YAML_FILE_PATH << '-o' << file.path
    begin
      cmd.run(params)
      data = file.gets(DATA_COUNT)
      refute_empty(data)
    ensure
      file.close
      file.unlink
    end
  end
end

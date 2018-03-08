# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '../test_helper')

class DumpCommandTest < Minitest::Test
  def test_it_dumps_to_yaml
    cmd = RBStarbound::MainCommand.new('', {})
    file = Tempfile.new('dump_cmd_test_temp')
    params = %w[dump -f yaml -i] << SAVE_FILE_PATH << '-o' << file.path
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

# frozen_string_literal: true

require 'test_helper'

class RBStarboundTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RBStarbound::VERSION
  end

  def test_it_does_ping
    expected_output = "Pong!\n"
    assert_output(expected_output) { ::RBStarbound.ping }
  end

  def test_it_parses_save_file
    expected_output = 'PlayerEntity'
    output = ::RBStarbound.parse_player_save_file(SAVE_FILE_PATH)['name']
    assert_equal(expected_output, output)
  end

  def test_it_shows_error_when_no_file_or_dir
    expected_output = ERROR_MSG + "No such file or directory\n"
    assert_output(expected_output) { ::RBStarbound.parse_player_save_file('') }
  end
end

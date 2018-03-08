# frozen_string_literal: true

require 'test_helper'

class PlayerTest < Minitest::Test
  def test_it_changes_player_name
    data = {
      'identity' => {
        'player_name' => 'John Doe'
      }
    }
    new_name = 'changed'
    player = RBStarbound::Player::Data.new('', 0, data)
    player.player_name = new_name
    assert_equal(player.player_name, new_name)
  end
end

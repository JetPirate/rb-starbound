# frozen_string_literal: true

require 'test_helper'

class SBVJ01Test < Minitest::Test
  def test_it_raises_header_error
    file = Tempfile.new('sbvj01_header_test_temp')
    assert_raises RBStarbound::SBVJ01Error do
      ::RBStarbound::SBVJ01.parse(file)
    end
    file.close
  end
end

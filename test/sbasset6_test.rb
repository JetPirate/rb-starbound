# frozen_string_literal: true

require 'test_helper'

class SBAsset6Test < Minitest::Test
  def test_it_requires_package_file
    assert_raises RBStarbound::SBAsset6Error do
      ::RBStarbound::SBAsset6.package(nil)
      ::RBStarbound::SBAsset6.get('path')
    end
  end

  def test_it_raises_header_error
    file = Tempfile.new('sbasset6_header_test_temp')
    begin
      file.write('NotAHeader')
      error = assert_raises RBStarbound::SBAsset6Error do
        ::RBStarbound::SBAsset6.package(file)
      end
      assert_match(/Invalid header/, error.message)
    ensure
      file.close
      file.unlink
    end
  end
end

# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rbstarbound'

require 'minitest/autorun'

data_version = ENV['TEST_DATA_VERSION'] || '1.3.3'

SAVE_FILE_PATH = File.expand_path("test/data/#{data_version}/test.player")

ERROR_MSG = 'An error occured: '

# frozen_string_literal: true

require 'rbstarbound/player'

module RBStarbound
  module SBVJ01
    def self.parse(io)
      unless sbvj01_header?(io)
        raise RBStarbound::SBVJ01Error, 'Not a SBVJ01 file'
      end
      read_player_data(io)
    end

    def self.dump(io, player_data)
      sbvj01_header(io)
      write_player_data(io, player_data)
    end

    def self.read_player_data(io)
      name = RBStarbound::SBON.read_string(io)
      version = nil
      version = io.read(4).unpack('i>').first unless io.readchar.ord.zero?
      data = RBStarbound::SBON.read_dynamic(io)
      RBStarbound::Player::Data.new(name, version, data)
    end

    def self.write_player_data(io, player_data)
      RBStarbound::SBON.write_string(io, player_data.name)
      if player_data.version.nil?
        io.write([0].pack('c'))
      else
        io.write([1, player_data.version].pack('ci>'))
      end
      RBStarbound::SBON.write_dynamic(io, player_data.data)
    end

    def self.sbvj01_header?(io)
      io.read(6) == 'SBVJ01'
    end

    def self.sbvj01_header(io)
      io.write('SBVJ01')
    end

    class << self
      private :sbvj01_header?, :sbvj01_header, :read_player_data,
              :write_player_data
    end
  end
end

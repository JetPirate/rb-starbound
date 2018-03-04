# frozen_string_literal: true

module RBStarbound
  module SBVJ01
    Player = Struct.new(:name, :version, :data) do
      def player_name
        data['identity']['name']
      end

      def uuid
        data['identity']['uuid']
      end
    end

    def self.parse(io)
      unless sbvj01_header?(io)
        raise RBStarbound::SBVJ01Error, 'Not a SBVJ01 file'
      end
      get_player_data(io)
    end

    def self.write(io)
      raise RBStarbound::NotImplementedError
    end

    def self.get_player_data(io)
      name = RBStarbound::SBON.read_string(io)
      version = 'None'
      version = io.read(4).unpack('i>') if io.readchar.ord != 0
      data = RBStarbound::SBON.read_dynamic(io)
      Player.new(name, version, data)
    end

    def self.sbvj01_header?(io)
      io.read(6) == 'SBVJ01'
    end

    class << self
      private :write, :get_player_data, :sbvj01_header?
    end
  end
end

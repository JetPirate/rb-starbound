# frozen_string_literal: true

module RBStarbound
  module SBON
    def self.read_varint(io)
      value = 0
      loop do
        byte = io.readchar.ord
        return value << 7 | byte if (byte & 0b10_00_00_00).zero?
        value = value << 7 | (byte & 0b01_11_11_11)
      end
    end

    def self.read_varint_signed(io)
      value = read_varint(io)
      # Least significant bit represents the sign.
      return -(value >> 1) - 1 unless (value & 1).zero?
      value >> 1
    end

    def self.read_bytes(io)
      length = read_varint(io)
      io.read(length)
    end

    def self.read_string(io)
      read_bytes(io)
    end

    def self.read_list(io)
      list = []
      read_varint(io).times do
        list << read_dynamic(io)
      end
      list
    end

    def self.read_map(io)
      map = {}
      read_varint(io).times do
        key = read_string(io)
        map[key] = read_dynamic(io)
      end
      map
    end

    def self.read_dynamic(io)
      case read_ord(io)
      when 1 then nil # nil value
      when 2 then io.read(8).unpack('G')[0] # double; big-endian
      when 3 then !read_ord(io).zero? # boolean value
      when 4 then read_varint_signed(io) # VLQ; signed
      when 5 then read_string(io) # string value
      when 6 then read_list(io) # list value (array)
      when 7 then read_map(io) # map value (hash)
      else raise RBStarbound::ValueError, 'Unknown dynamic type'
      end
    end

    def self.read_ord(io)
      io.readchar.ord
    end

    class << self
      private :read_ord
    end
  end
end

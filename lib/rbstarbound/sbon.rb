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

    def self.write_varint(io, value)
      buf = (value & 0b01_11_11_11).chr
      value >>= 7
      until value.zero?
        buf = (value & 0b01_11_11_11 | 0b10_00_00_00).chr + buf
        value >>= 7
      end
      io.write(buf)
    end

    def self.read_varint_signed(io)
      value = read_varint(io)
      # Least significant bit represents the sign.
      return -(value >> 1) - 1 unless (value & 1).zero?
      value >> 1
    end

    def self.write_varint_signed(io, value)
      if value < 0
        write_varint(io, (-(value + 1) << 1 | 1))
      else
        write_varint(io, value << 1)
      end
    end

    def self.read_bytes(io)
      length = read_varint(io)
      io.read(length)
    end

    def self.write_bytes(io, data)
      write_varint(io, data.length)
      io.write(data)
    end

    def self.read_string(io)
      read_bytes(io)
    end

    def self.write_string(io, data)
      write_bytes(io, data)
    end

    def self.read_list(io)
      list = []
      read_varint(io).times do
        list << read_dynamic(io)
      end
      list
    end

    def self.write_list(io, list)
      write_varint(io, list.length)
      list.each do |item|
        write_dynamic(io, item)
      end
    end

    def self.read_map(io)
      map = {}
      read_varint(io).times do
        key = read_string(io)
        map[key] = read_dynamic(io)
      end
      map
    end

    def self.write_map(io, map)
      write_varint(io, map.length)
      map.each_pair do |key, val|
        write_string(io, key)
        write_dynamic(io, val)
      end
    end

    def self.read_dynamic(io)
      case read_data_type(io)
      when 1 then read_nil(io)
      when 2 then read_double(io) # big-endian
      when 3 then read_bool(io)
      when 4 then read_integer(io) # VLQ; signed
      when 5 then read_str(io)
      when 6 then read_array(io)
      when 7 then read_hash(io)
      else raise RBStarbound::ValueError, 'Unknown dynamic type'
      end
    end

    def self.write_dynamic(io, data)
      case data
      when nil                   then write_nil(io)
      when Float                 then write_double(io, data)
      when TrueClass, FalseClass then write_bool(io, data)
      when Integer               then write_integer(io, data)
      when String                then write_str(io, data)
      when Array                 then write_array(io, data)
      when Hash                  then write_hash(io, data)
      else raise ValueError, 'Cannot write value'
      end
    end

    def self.read_data_type(io)
      io.readchar.ord
    end

    def self.read_bool(io)
      !read_data_type(io).zero?
    end

    def self.write_bool(io, value)
      if value.is_a? TrueClass
        io.write("\x03\x01".b)
      else
        io.write("\x03\x00".b)
      end
    end

    def self.read_double(io)
      io.read(8).unpack('G').first
    end

    def self.write_double(io, value)
      io.write("\x02".b)
      io.write([value].pack('G'))
    end

    def self.read_integer(io)
      read_varint_signed(io)
    end

    def self.write_integer(io, data)
      io.write("\x04".b)
      write_varint_signed(io, data)
    end

    def self.read_str(io)
      read_string(io)
    end

    def self.write_str(io, data)
      io.write("\x05".b)
      write_string(io, data)
    end

    def self.read_array(io)
      read_list(io)
    end

    def self.write_array(io, data)
      io.write("\x06".b)
      write_list(io, data)
    end

    def self.read_hash(io)
      read_map(io)
    end

    def self.write_hash(io, data)
      io.write("\x07".b)
      write_map(io, data)
    end

    def self.read_nil(_)
      nil
    end

    def self.write_nil(io)
      io.write("\x01".b)
    end

    class << self
      private :read_data_type, :read_nil, :read_bool, :read_double,
              :read_integer, :read_str, :read_array, :read_hash, :write_nil,
              :write_bool, :write_double, :write_integer, :write_str,
              :write_array, :write_hash
    end
  end
end

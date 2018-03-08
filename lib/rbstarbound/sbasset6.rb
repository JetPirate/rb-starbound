# frozen_string_literal: true

module RBStarbound
  module SBAsset6
    @verbose = false

    def self.package(io)
      @package = io
      raise SBAsset6Error, 'No package file given' if @package.nil?
      read_header
      read_index
    end

    def self.get(path)
      raise SBAsset6Error, 'No package file given' if @package.nil?
      offset, length = @index[path]
      rewind_to(offset)
      @package.read(length)
    end

    def self.read_header
      rewind_to(0)
      header, @metadata_offset = @package.read(16).unpack('A8Q>')
      raise SBAsset6Error, 'Invalid header' unless header == 'SBAsset6'
      read_metadata
    end

    def self.read_index
      puts 'Loading index...' if @verbose
      rewind_to(@index_offset)
      @index = {}
      @file_count.times do
        path = RBStarbound::SBON.read_string(@package)
        offset, length = @package.read(16).unpack('Q>Q>')
        @index[path] = [offset, length]
      end
      puts 'Index loaded.' if @verbose
    end

    def self.read_metadata
      rewind_to(@metadata_offset)
      raise SBAsset6Error, 'Invalid index data' unless meta_header == 'INDEX'
      @metadata = RBStarbound::SBON.read_map(@package)
      @file_count = RBStarbound::SBON.read_varint(@package)
      @index_offset = @package.pos
    end

    def self.rewind_to(pos)
      @package.seek(pos, IO::SEEK_SET)
    end

    def self.meta_header
      @package.read(5)
    end

    class << self
      attr_accessor :verbose
      attr_reader :metadata, :file_count, :metadata_offset, :index_offset,
                  :index
      private :rewind_to, :read_header, :read_index, :read_metadata
    end
  end
end

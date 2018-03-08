# frozen_string_literal: true

require 'fileutils'

module RBStarbound
  class ExportCommand < Clamp::Command
    option ['-d', '--dir'], 'DIR', 'directory to extract the files to',
           required: true
    option ['-p', '--package'], 'PAK', 'the package file to extract from',
           required: true
    option ['-v', '--verbose'], :flag, 'be verbose', default: false

    def execute
      start = Time.now.to_i
      extracted = 0
      begin
        File.open(package.to_s, 'rb') do |file|
          RBStarbound::SBAsset6.verbose = true if verbose?
          RBStarbound::SBAsset6.package(file)
          if verbose?
            puts "Extracting #{RBStarbound::SBAsset6.file_count} files..."
          end
          percentage = [RBStarbound::SBAsset6.file_count / 100, 1].max
          RBStarbound::SBAsset6.index.each_key do |path|
            dest_path = dir + path
            dest_dir, = File.split(dest_path)
            FileUtils.mkdir_p(dest_dir) unless Dir.exist?(dest_dir)
            data = RBStarbound::SBAsset6.get(path)
            File.open(dest_path, 'wb') { |f| f.write(data) }
            extracted += 1
            next unless verbose?
            putc '.' if (extracted % percentage).zero?
          end
        end
        return RBStarbound::EX_OK unless verbose?
        puts
        puts "Extracted #{extracted} files in #{Time.now.to_i - start} seconds."
        return RBStarbound::EX_OK
      rescue StandardError => e
        RBStarbound.print_error(e)
        return RBStarbound::EX_ERR
      end
    end
  end
end

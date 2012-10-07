module Cucumber
  module Analytics
    class ParsedDirectory

      attr_reader :feature_files
      attr_reader :feature_directories

      def initialize(directory_parsed = nil)
        @directory = directory_parsed

        @feature_files = []
        @feature_directories = []

        scan_directory if directory_parsed
      end

      def feature_count
        @feature_files.count + @feature_directories.reduce(0) { |sum, feature_directory| sum += feature_directory.feature_count }
      end

      def contains
        @feature_files + @feature_directories
      end


      private


      def scan_directory
        entries = Dir.entries(@directory)
        entries.delete '.'
        entries.delete '..'

        entries.each do |entry|
          entry = @directory + '/' + entry
          @feature_directories << ParsedDirectory.new(entry) if File.directory?(entry)
          @feature_files << ParsedFile.new(entry) if entry =~ /\.feature$/
        end
      end

    end
  end
end

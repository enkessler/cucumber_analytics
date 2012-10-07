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

      def steps(include_keywords = true)
        directory_steps = feature_files.reduce([]) { |accumulated_steps, feature_file| accumulated_steps.concat(feature_file.steps(include_keywords)) }
        subdirectory_steps = feature_directories.reduce([]) { |accumulated_steps, directory| accumulated_steps.concat(directory.steps(include_keywords)) }

        directory_steps.concat(subdirectory_steps)
      end

      def defined_steps(include_keywords = true)
        directory_steps = feature_files.reduce([]) { |accumulated_steps, feature_file| accumulated_steps.concat(feature_file.defined_steps(include_keywords)) }
        subdirectory_steps = feature_directories.reduce([]) { |accumulated_steps, directory| accumulated_steps.concat(directory.defined_steps(include_keywords)) }

        directory_steps.concat(subdirectory_steps)
      end

      def undefined_steps(include_keywords = true)
        directory_steps = feature_files.reduce([]) { |accumulated_steps, feature_file| accumulated_steps.concat(feature_file.undefined_steps(include_keywords)) }
        subdirectory_steps = feature_directories.reduce([]) { |accumulated_steps, directory| accumulated_steps.concat(directory.undefined_steps(include_keywords)) }

        directory_steps.concat(subdirectory_steps)
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

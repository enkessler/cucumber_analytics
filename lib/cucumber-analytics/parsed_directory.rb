module Cucumber
  module Analytics
    class ParsedDirectory

      attr_reader :feature_files

      def initialize(directory_parsed)
        @feature_files = []
        #puts "directory to lex: #{directory_parsed}"
        @directory = directory_parsed
        extract_feature_files
      end

      def feature_count
        #puts "directory #{@directory}'s feature files:"
        #puts @feature_files
        @feature_files.count
      end

      def extract_feature_files
        #puts 'extracting files'
        #Dir.glob("#{@directory}/**/*").each do |file|
        #  puts "file found: #{file}"
        #end

      Dir.glob("#{@directory}/**/*.feature").each do |file|
        #puts "feature file found: #{file}"
        @feature_files << ParsedFile.new(file)
      end

      end

    end
  end
end

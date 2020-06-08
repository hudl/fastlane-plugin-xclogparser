require 'fastlane/action'
require_relative '../helper/xclogparser_helper'
require 'time'

module Fastlane
  module Actions
    class XclogparserAction < Action
      def self.run(params)
        UI.message("The xclogparser plugin is working!")
      end

      def self.description
        "Parse Xcode or xcodebuild build and test logs with XCLogParser"
      end

      def self.authors
        ["Josh Lesch"]
      end

      def self.details
        "XCLogParser is a CLI tool that parses the SLF serialization format used by Xcode and xcodebuild to store its Build and Test logs (xcactivitylog files). This plugin provides an easy way to run XCLogParser against your builds."
      end

      def self.available_options
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end

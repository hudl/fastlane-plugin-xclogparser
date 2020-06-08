require 'fastlane/action'
require_relative '../helper/xclogparser_helper'
require 'time'

module Fastlane
  module Actions
    class XclogparserAction < Action
      def self.run(params)
        Helper::XclogparserHelper.check_if_installed

        command = params[:command].downcase

        if command.eql?('parse')
          options = params[:options]
          if options == "" || options == [] || options == nil
            UI.user_error!("--reporter and oreporterne of --file, --project, --workspace, --xcodeproj parameters is required.\nSee https://github.com/spotify/XCLogParser#parse-command for more information about the Parse command.")
          end
          options = format_options(options)
        end

        xclogparse_command = ['xclogparser', command, options].compact.join(" ")

        begin
          xclogparse_output = Action.sh(xclogparse_command)
        rescue FastlaneCore::Interface::FastlaneShellError => e
          if e.message.include?("//Logs/Build")
            UI.error("Since Xcode 11, xcodebuild only generates the .xcactivitylog build logs when the option --resultBundlePath. If you're compiling with that command and not with Xcode, be sure to set that option to a valid path")
          end
          UI.user_error!(e.message)
        end

        if params[:zip_html_report]
          report_path = parse_output_for_html_report(xclogparse_output)
          report_directory = File.dirname(report_path)
          report_time = Time.parse(File.basename(report_directory))
          zip_name = "xclogparser_report_#{report_time.strftime("%Y-%m-%d-%H%M%S")}.zip"
          root_dir = Dir.pwd
          Dir.chdir(report_directory) do
            Action.sh("zip -r -X #{File.join(root_dir, zip_name)} .")
          end
        end
        xclogparse_output
      end

      def self.format_options(options)
        if options.kind_of?(Array)
          options.map! { |i| i.include?("--") ? i : "--#{i}" }
        else
          options.include?("--") ? options : "--#{options}"
        end
      end

      def self.parse_output_for_html_report(unparsed_output)
        unparsed_output.split("Report written to ")[1]
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
        [
          FastlaneCore::ConfigItem.new(key: :command,
                                       description: "XCLogParse command. Run `xclogparse help` to list availabel commands",
                                       default_value: "parse",
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :options,
                                       description: "Options for the XCLogParse command",
                                       is_string: false,
                                       optional: true,
                                       verify_block: -> (value) {
                                        case value when String; when Array;
                                          else  UI.user_error! "Invalid option: #{value.inspect}, must be an Array or String"
                                        end
                                       }),
          FastlaneCore::ConfigItem.new(key: :zip_html_report,
                                       description: "Zip HTML report for transport",
                                       is_string: false,
                                       default_value: false,
                                       optional: true)
        ]
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

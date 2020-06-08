require 'fastlane_core/ui/ui'
require 'net/http'
require 'json'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class XclogparserHelper
      def self.check_if_installed
        command = ['xclogparser', 'version']
        begin
          version = Action.sh(command).match(/(\d+\.)?(\d+\.)?(\d+)/)[0]
        rescue Errno::ENOENT => e
          raise e unless e.message.include?("No such file or directory - xclogparser")
          UI.user_error!("Could not find XCLogParser. Please install using `brew install xclogparser` or verify that it is installed correctly.")
        end
        check_for_updates(version)
      end

      def self.check_for_updates(installed_version)
        command = ['brew', 'outdated', 'xclogparser', '--json']
        # Brew returns a non-zero exit code if the formula is outdated
        res = Actions.sh(command, log: false, error_callback: ->(result) {})
        json_res = JSON.parse(res)
        return if json_res.empty?
        UI.important("\n#############################################################\n"\
                     "#  XCLogParser #{json_res[0]['current_version']} is available. You are on #{installed_version}.\n"\
                     "#  You can update using `brew upgrade xclogparser`    "\
                     "\n#############################################################")
      end
    end
  end
end

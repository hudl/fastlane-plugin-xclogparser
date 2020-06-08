require 'fastlane_core/ui/ui'
require 'net/http'
require 'json'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class XclogparserHelper
    end
  end
end

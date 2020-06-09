describe Fastlane::Actions::XclogparserAction do
  describe 'XCLogParser Action' do
    it 'format options' do
      expected_array = ["--project test", "--project test"]
      expected_string = "--project test"
      expect(Fastlane::Actions::XclogparserAction.format_options(["--project test", "project test"])).to eq(expected_array)
      expect(Fastlane::Actions::XclogparserAction.format_options(["project test", "--project test"])).to eq(expected_array)
      expect(Fastlane::Actions::XclogparserAction.format_options(["project test", "project test"])).to eq(expected_array)
      expect(Fastlane::Actions::XclogparserAction.format_options(["--project test", "--project test"])).to eq(expected_array)
      expect(Fastlane::Actions::XclogparserAction.format_options("project test")).to eq(expected_string)
      expect(Fastlane::Actions::XclogparserAction.format_options("--project test")).to eq(expected_string)
    end
  end
end

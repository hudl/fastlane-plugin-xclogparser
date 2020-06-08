describe Fastlane::Actions::XclogparserAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The xclogparser plugin is working!")

      Fastlane::Actions::XclogparserAction.run(nil)
    end
  end
end

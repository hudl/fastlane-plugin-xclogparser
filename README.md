# xclogparser plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xclogparser)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-xclogparser`, add it to your project by running:

```bash
fastlane add_plugin xclogparser
```

## About xclogparser

[XCLogParser](https://github.com/spotify/XCLogParser) is a CLI tool that parses the SLF serialization format used by Xcode and xcodebuild to store its Build and Test logs (xcactivitylog files). This plugin provides an easy way to run XCLogParser against your builds.

It is a prerequisite that `XCLogParser` is installed globally on the same machine that will be executing your Fastfile. You can find the install instruction [here](https://github.com/spotify/XCLogParser#installation) or install with `brew install xclogparser`

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

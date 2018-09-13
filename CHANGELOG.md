# Change Log
This project adheres to [Semantic Versioning](http://semver.org/).

This CHANGELOG follows the format located [here](https://github.com/sensu-plugins/community/blob/master/HOW_WE_CHANGELOG.md)

## [Unreleased]

### Security
- updated `yard` dependency to `~> 0.9.11` per: https://nvd.nist.gov/vuln/detail/CVE-2017-17042 which closes attacks against a yard server loading arbitrary files (@majormoses)
- updated rubocop dependency to `~> 0.51.0` per: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-8418. (@majormoses)

### Breaking Changes
- removed ruby versions `< 2.3` support (@majormoses)
- bumped `sensu-plugin` to `~> 2.7` which removes in handler event filtering you can read about it  [here](https://github.com/sensu-plugins/sensu-plugin/blob/master/CHANGELOG.md#v145---2017-03-07)(@majormoses)

### Fixed
- fix `handler-microsoft-teams.rb`: rescue any non sensu specification compliant status code passed to the microsoft-teams handler as the color matching `unknown` (@majormoses)

### Changed
- appeased the cops (@majormoses)

## [1.3.1] - 2018-09-12
### Fixed
- Add erubis gem as a startup dependency (@asachs01)

### Changed
- Updated CONTRIBUTING.md to point to new docs site (@asachs01)
- Updated README with better installation instructions (@asachs01)

## [1.3.0] - 2017-10-10
### Added
- gitignore (@majormoses)
- rubocop config (@majormoses)

### Changed
- update changelog guidelines location (@majormoses)
- travis config for testing and deploment to rubygems (@majormoses)
- handler-microsoft-teams.rb: appease the cops (@majormoses)

## [1.2.2]
### Changed
- removed references in README to `skel` (@tuxpower)

### Added
- usage for  `handler-microsoft-teams.rb` (@tuxpower)

## [1.2.1]
### Breaking Changes
- removed optional `clientkeys` fields (@tuxpower)

## [1.2.0]
### Added
- OpenUri action type (@tuxpower)

## [1.1.0]
### Added
- activityImage option (@tuxpower)

## [1.0.0]
- working version (@tuxpower)

## [0.0.6]
### Added
- adapting code from slack plugin as reference (@tuxpower)

## [0.0.5]
### Changed
- mulligan (@tuxpower)

## [0.0.4]
### Fixed
- use `teams_url` over `webhook_url` (@tuxpower)

## [0.0.3]
### Fixed
- updated references of `Slack` to `MicrosoftTeams` (@tuxpower)

## [0.0.2]
### Added
- handler-microsoft-teams.rb: handler to send events to microsoft teams (@tuxpower)

## [0.0.1]
### Changed
- updated references of `skel` to `microsoft-teams` (@tuxpower)


[Unreleased]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/1.3.1...HEAD
[1.3.1]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/1.3.0...1.3.1
[1.3.0]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v1.2.2...1.3.0
[1.2.2]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v1.2.1...v1.2.2
[1.2.1]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v1.2.0...v1.2.1
[1.2.0]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v0.0.6...v1.0.0
[0.0.6]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v0.0.5...v0.0.6
[0.0.5]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v0.0.4...v0.0.5
[0.0.4]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v0.0.3...v0.0.4
[0.0.3]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v0.0.1...v0.0.3
[0.0.2]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/v0.0.1...v0.0.2
[0.0.1]: https://github.com/sensu-plugins/sensu-plugins-microsoft-teams/compare/0b2d68b64a3d100c10da5e4cfce42206b9f22250...v0.0.1

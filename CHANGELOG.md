<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v1.8.1](https://github.com/puppetlabs/puppetlabs-facts/tree/v1.8.1) - 2026-10-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.7.0...v1.8.1)

### Changed

- (BOLT-193): facts pdk update for Puppet 9 compatibility [#71](https://github.com/puppetlabs/puppetlabs-facts/pull/71) ([gavindidrichsen](https://github.com/gavindidrichsen))

### Fixed

- (BOLT-205) Revert outputs for SuSE and Almalinux [#80](https://github.com/puppetlabs/puppetlabs-facts/pull/80) ([gavindidrichsen](https://github.com/gavindidrichsen))

## [1.7.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.7.0) - 2024-12-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.6.0...1.7.0)

### Added

- (BOLT-43) Puppet 8 compatibility [#63](https://github.com/puppetlabs/puppetlabs-facts/pull/63) ([LukasAud](https://github.com/LukasAud))

## [1.6.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.6.0) - 2024-08-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.4.0...1.6.0)

### Changed

- (PE-37656) - Puppet version compatibility [#59](https://github.com/puppetlabs/puppetlabs-facts/pull/59) ([Ramesh7](https://github.com/Ramesh7))

### Added

- (maint) Adjust FreeBSD capitalization [#54](https://github.com/puppetlabs/puppetlabs-facts/pull/54) ([smortex](https://github.com/smortex))

## [1.4.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.4.0) - 2021-01-22

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.3.0...1.4.0)

### Added

- (maint) Bump maximum Puppet version to include 7.x [#52](https://github.com/puppetlabs/puppetlabs-facts/pull/52) ([lucywyman](https://github.com/lucywyman))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.3.0) - 2021-01-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.2.0...1.3.0)

### Fixed

- (maint) Clean up task metadata [#51](https://github.com/puppetlabs/puppetlabs-facts/pull/51) ([donoghuc](https://github.com/donoghuc))
- Use bat files if possible [#49](https://github.com/puppetlabs/puppetlabs-facts/pull/49) ([carabasdaniel](https://github.com/carabasdaniel))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.2.0) - 2020-11-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.1.0...1.2.0)

### Added

- (MODULES-10833) Use puppet facts show on Puppet 7 [#46](https://github.com/puppetlabs/puppetlabs-facts/pull/46) ([BogdanIrimie](https://github.com/BogdanIrimie))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.1.0) - 2020-10-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/1.0.0...1.1.0)

### Added

- (IAC-1127) search for facter.exe on Windows platforms [#44](https://github.com/puppetlabs/puppetlabs-facts/pull/44) ([mihaibuzgau](https://github.com/mihaibuzgau))
- (GH-1981) Add external facts plan [#41](https://github.com/puppetlabs/puppetlabs-facts/pull/41) ([lucywyman](https://github.com/lucywyman))

### Fixed

- Bubble up errors from facter if any [#45](https://github.com/puppetlabs/puppetlabs-facts/pull/45) ([npwalker](https://github.com/npwalker))
- (bug-fix) Use RbConfig.ruby instead of hardcoded path [#39](https://github.com/puppetlabs/puppetlabs-facts/pull/39) ([lucywyman](https://github.com/lucywyman))

## [1.0.0](https://github.com/puppetlabs/puppetlabs-facts/tree/1.0.0) - 2020-01-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.6.0...1.0.0)

### Changed

- (GH-1376) Change $nodes param to $targets in plans [#31](https://github.com/puppetlabs/puppetlabs-facts/pull/31) ([beechtom](https://github.com/beechtom))

### Fixed

- Delegate to facter if installed [#36](https://github.com/puppetlabs/puppetlabs-facts/pull/36) ([nicklewis](https://github.com/nicklewis))
- (GH-34) Return version when using `uname` [#35](https://github.com/puppetlabs/puppetlabs-facts/pull/35) ([beechtom](https://github.com/beechtom))
- Source facts for systemd platforms using bash 3.1 and 3.2 [#32](https://github.com/puppetlabs/puppetlabs-facts/pull/32) ([beechtom](https://github.com/beechtom))

## [0.6.0](https://github.com/puppetlabs/puppetlabs-facts/tree/0.6.0) - 2019-08-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.5.1...0.6.0)

### Added

- (MODULES-9530) Mirror C++ facter structure for codename [#30](https://github.com/puppetlabs/puppetlabs-facts/pull/30) ([donoghuc](https://github.com/donoghuc))

### Fixed

- (FM-7967) Ensure bash script EOL is LF [#27](https://github.com/puppetlabs/puppetlabs-facts/pull/27) ([michaeltlombardi](https://github.com/michaeltlombardi))

## [0.5.1](https://github.com/puppetlabs/puppetlabs-facts/tree/0.5.1) - 2019-04-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.5.0...0.5.1)

### Fixed

- (MODULES-8750) Improve facts bash task implementation [#25](https://github.com/puppetlabs/puppetlabs-facts/pull/25) ([donoghuc](https://github.com/donoghuc))
- (BOLT-1057) Pass required args to run_task [#22](https://github.com/puppetlabs/puppetlabs-facts/pull/22) ([nicklewis](https://github.com/nicklewis))

## [0.5.0](https://github.com/puppetlabs/puppetlabs-facts/tree/0.5.0) - 2019-01-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.4.1...0.5.0)

### Added

- (BOLT-997) Clean bash implementation for RedHat [#19](https://github.com/puppetlabs/puppetlabs-facts/pull/19) ([donoghuc](https://github.com/donoghuc))

### Fixed

- (BOLT-997) Only use facter when puppet-agent feature is available [#17](https://github.com/puppetlabs/puppetlabs-facts/pull/17) ([donoghuc](https://github.com/donoghuc))
- (MODULES-8392) Hide extra implementations [#16](https://github.com/puppetlabs/puppetlabs-facts/pull/16) ([MikaelSmith](https://github.com/MikaelSmith))

## [0.4.1](https://github.com/puppetlabs/puppetlabs-facts/tree/0.4.1) - 2018-10-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.4.0...0.4.1)

### Fixed

- (BOLT-915) Do not run bash.sh against windows targets [#15](https://github.com/puppetlabs/puppetlabs-facts/pull/15) ([donoghuc](https://github.com/donoghuc))

## [0.4.0](https://github.com/puppetlabs/puppetlabs-facts/tree/0.4.0) - 2018-10-18

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.3.1...0.4.0)

### Added

- (BOLT-915) Make bash.sh facts implementation shareable [#13](https://github.com/puppetlabs/puppetlabs-facts/pull/13) ([donoghuc](https://github.com/donoghuc))

## [0.3.1](https://github.com/puppetlabs/puppetlabs-facts/tree/0.3.1) - 2018-09-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.3.0...0.3.1)

## [0.3.0](https://github.com/puppetlabs/puppetlabs-facts/tree/0.3.0) - 2018-09-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.2.0...0.3.0)

### Added

- (maint) Task improvements [#9](https://github.com/puppetlabs/puppetlabs-facts/pull/9) ([MikaelSmith](https://github.com/MikaelSmith))

## [0.2.0](https://github.com/puppetlabs/puppetlabs-facts/tree/0.2.0) - 2018-07-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.1.2...0.2.0)

### Added

- (BOLT-690) Add legacy facts to results [#5](https://github.com/puppetlabs/puppetlabs-facts/pull/5) ([MikaelSmith](https://github.com/MikaelSmith))

### Fixed

- (BOLT-688) Expand search for facter task [#6](https://github.com/puppetlabs/puppetlabs-facts/pull/6) ([donoghuc](https://github.com/donoghuc))
- (maint) Minor module cleanup [#4](https://github.com/puppetlabs/puppetlabs-facts/pull/4) ([MikaelSmith](https://github.com/MikaelSmith))

## [0.1.2](https://github.com/puppetlabs/puppetlabs-facts/tree/0.1.2) - 2018-06-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/puppetlabs/puppetlabs-facts/tree/0.1.1) - 2018-06-07

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/0.1.0...0.1.1)

### Added

- (BOLT-533) Add json files for different implementations [#3](https://github.com/puppetlabs/puppetlabs-facts/pull/3) ([lucywyman](https://github.com/lucywyman))

## [0.1.0](https://github.com/puppetlabs/puppetlabs-facts/tree/0.1.0) - 2018-06-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-facts/compare/fea5ca22694f0352a7556599592bf55f4c16f6fa...0.1.0)

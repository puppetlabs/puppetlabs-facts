# Change Log

## 0.3.0
### Fixed
- Task metadata specifies environment input to work around BOLT-691.

### Changed
- Stop hiding failures gathering facts in the `facts` plan.

### Removed
- `facts::retrieve` as redundant with the `facts` task when cross-platform
tasks are supported.

## 0.2.0
### Added
- Legacy facts added to results.
- Improve ability of bash and ruby task to find facter executable path.

## 0.1.2

### Changed
- Move facts to external module (from bolt).

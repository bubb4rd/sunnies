# Sunnies

Native iOS (SwiftUI, iOS 17+) eyewear discovery app: see glasses you like, find the exact pair when possible — or the closest pair you can buy. The MVP runs entirely on local mock services.

- Product and agent context: [`docs/agent-context.md`](docs/agent-context.md)
- Decisions: [`docs/decision-log.md`](docs/decision-log.md)

## Build and test

```sh
xcodebuild -project Sunnies.xcodeproj -scheme Sunnies \
  -destination 'platform=iOS Simulator,name=iPhone 17' build

xcodebuild -project Sunnies.xcodeproj -scheme Sunnies \
  -destination 'platform=iOS Simulator,name=iPhone 17' test

# unit tests only
xcodebuild ... test -only-testing:SunniesTests
```

Use `xcrun simctl list devices available` to find a simulator name.

## Mock scenarios

DEBUG builds read `-SunniesSampleImage` (adds a "Use sample photo" button for UI tests) and `-SunniesMockScenario <name>` (scheme → Run → Arguments): `exactMatch`, `likelyMatch`, `similarStyles` (default), `styleOnly`, `noResults`, `serviceFailure`, `timeout`, `malformedResponse`.

## Layout

```
Sunnies/
  App/            entry point, AppEnvironment (DI), launch config
  Presentation/   design system, navigation, feature screens
  Domain/         models, service protocols, errors, ConfidencePolicy
  Data/           mock services, fixtures, response decoding
SunniesTests/     Swift Testing unit tests
SunniesUITests/   XCTest UI tests
```

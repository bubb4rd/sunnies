import XCTest

@MainActor
final class AppShellSmokeTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func testLaunchShowsDiscoverAndSavedTabs() {
        let app = XCUIApplication()
        app.launchArguments = ["-SunniesMockScenario", "similarStyles"]
        app.launch()

        XCTAssertTrue(app.buttons["Find these glasses"].waitForExistence(timeout: 5))

        app.tabBars.buttons["Saved"].tap()
        XCTAssertTrue(app.staticTexts["No saved frames yet"].waitForExistence(timeout: 5))
    }

    func testFindGlassesOpensAndClosesSearchFlow() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["Find these glasses"].tap()
        XCTAssertTrue(app.buttons["Close"].waitForExistence(timeout: 5))
        app.buttons["Close"].tap()
        XCTAssertTrue(app.buttons["Find these glasses"].waitForExistence(timeout: 5))
    }
}

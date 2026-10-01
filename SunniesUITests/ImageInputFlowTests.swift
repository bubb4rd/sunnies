import XCTest

@MainActor
final class ImageInputFlowTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    func testSelectPreviewAndContinueToCrop() {
        let app = launchToImageInput()
        XCTAssertTrue(app.buttons["Choose photo"].waitForExistence(timeout: 5))
        attachScreenshot(named: "image-input-empty")
        app.buttons["Use sample photo"].tap()

        XCTAssertTrue(app.images["selectedPhotoPreview"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Replace"].exists)
        attachScreenshot(named: "image-input-loaded")

        app.buttons["Continue"].tap()
        XCTAssertTrue(app.staticTexts["Cropping is coming next"].waitForExistence(timeout: 5))
    }

    func testRemoveReturnsToEmptyState() {
        let app = launchToImageInput()
        app.buttons["Use sample photo"].tap()
        XCTAssertTrue(app.images["selectedPhotoPreview"].waitForExistence(timeout: 5))

        app.buttons["Remove"].tap()
        XCTAssertTrue(app.buttons["Choose photo"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.images["selectedPhotoPreview"].exists)
    }

    private func launchToImageInput() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["-SunniesSampleImage"]
        app.launch()
        app.buttons["Find these glasses"].tap()
        return app
    }

    /// Kept in the result bundle for design review of each state.
    private func attachScreenshot(named name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

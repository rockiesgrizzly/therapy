import XCTest
@testable import Therapy

@MainActor
final class TherapyUITests: XCTestCase {
    private var application: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        application = XCUIApplication()
    }

    func testDateTasksScreen() async throws {
        application.launch()
        XCTAssert(application.staticTexts["My Tasks"].exists)
    }
    
    func testBreathScreen() async throws {
        application.launch()
        XCUIApplication().staticTexts["October 22"].tap()
        XCTAssert(application.staticTexts["Breathe for"].exists)
    }
    
    // TODO: Test all remaining screens
}

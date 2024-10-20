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
        XCTAssert(application.staticTexts[DatesListViewModel.titleText].exists)
    }
    
    func testBreathScreen() async throws {
        application.launch()
        XCUIApplication().staticTexts["October 22"].tap()
        XCTAssert(application.staticTexts[BreathViewModel.title].exists)
    }
    
    // TODO: Test all remaining screens
}

import XCTest
@testable import NotationModel

class NotationModelTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(NotationModel().text, "Hello, World!")
    }


    static var allTests : [(String, (NotationModelTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

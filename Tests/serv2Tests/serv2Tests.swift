import XCTest
@testable import serv2

final class serv2Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(serv2().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

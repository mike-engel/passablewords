import XCTest
@testable import sec_check

class sec_checkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sec_check().text, "Hello, World!")
    }


    static var allTests : [(String, (sec_checkTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

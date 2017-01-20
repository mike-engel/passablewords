import XCTest
@testable import passablewords

class passablewordsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(passablewordsk().text, "Hello, World!")
    }


    static var allTests : [(String, (passableWordsTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

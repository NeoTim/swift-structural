import XCTest

@testable import GenericCore
@testable import GenericExamples

final class EncodeJSONGenericTests: XCTestCase {
    func testPoint3() {
        let point = Point3(x: 10, y: 20, z: 30)
        XCTAssertEqual(toJSONString(point), "{\"x\":10,\"y\":20,\"z\":30}")
    }

    static var allTests = [
        ("testPoint3", testPoint3),
    ]
}
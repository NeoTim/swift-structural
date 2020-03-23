import XCTest

@testable import GenericCore
@testable import GenericExamples

final class ComparableGenericTests: XCTestCase {
    func testPoint3() {
        let point1 = Point3(_1: 10, _2: 20, _3: 30)
        let point2 = Point3(_1: 10, _2: 20, _3: 40)
        let point3 = Point3(_1: 10, _2: 30, _3: 40)
        let point4 = Point3(_1: 30, _2: 40, _3: 50)

        // Reflexivity of <=
        XCTAssertTrue(point1.genericLessOrEqual(point1))
        XCTAssertTrue(point2.genericLessOrEqual(point2))
        XCTAssertTrue(point3.genericLessOrEqual(point3))
        XCTAssertTrue(point4.genericLessOrEqual(point4))

        // Reflexivity of >=
        XCTAssertTrue(point1.genericGreaterOrEqual(point1))
        XCTAssertTrue(point2.genericGreaterOrEqual(point2))
        XCTAssertTrue(point3.genericGreaterOrEqual(point3))
        XCTAssertTrue(point4.genericGreaterOrEqual(point4))

        // Ordering on < and <=
        XCTAssertTrue(point1.genericLess(point2))
        XCTAssertTrue(point1.genericLessOrEqual(point2))
        XCTAssertTrue(point2.genericLess(point3))
        XCTAssertTrue(point2.genericLessOrEqual(point3))
        XCTAssertTrue(point3.genericLess(point4))
        XCTAssertTrue(point3.genericLessOrEqual(point4))

        // Ordering on > and >=
        XCTAssertTrue(point4.genericGreater(point3))
        XCTAssertTrue(point4.genericGreaterOrEqual(point3))
        XCTAssertTrue(point3.genericGreater(point2))
        XCTAssertTrue(point3.genericGreaterOrEqual(point2))
        XCTAssertTrue(point2.genericGreater(point1))
        XCTAssertTrue(point2.genericGreaterOrEqual(point1))
    }

    static var allTests = [
        ("testPoint3", testPoint3),
    ]
}

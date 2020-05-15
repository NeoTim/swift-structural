import Dispatch
import XCTest

@testable import StructuralCore
@testable import StructuralExamples

final class HashableStructuralTests: XCTestCase {
    func testPoint3() {
        let pointA = Point3(_1: 10, _2: 20, _3: 30)
        let pointB = Point3(_1: 30, _2: 20, _3: 10)
        XCTAssertEqual(referenceHash(pointA), genericHash(pointA))
        XCTAssertEqual(referenceHash(pointB), genericHash(pointB))
    }

    func testBinaryTree() {
        let treeA: BinaryTree<Int> = .branch(.leaf(1), 2, .branch(.leaf(3), 4, .leaf(5)))
        let treeB: BinaryTree<Int> = .branch(.leaf(42), 0, .leaf(21))
        XCTAssertEqual(referenceHash(treeA), genericHash(treeA))
        XCTAssertEqual(referenceHash(treeB), genericHash(treeB))
    }

    func testColor() {
        XCTAssertEqual(referenceHash(Color.red), genericHash(Color.red))
        XCTAssertEqual(referenceHash(Color.green), genericHash(Color.green))
        XCTAssertEqual(referenceHash(Color.blue), genericHash(Color.blue))
    }

    func testASCII() {
        XCTAssertEqual(referenceHash(ASCII.tab), genericHash(ASCII.tab))
        XCTAssertEqual(referenceHash(ASCII.lineFeed), genericHash(ASCII.lineFeed))
        XCTAssertEqual(referenceHash(ASCII.carriageReturn), genericHash(ASCII.carriageReturn))
    }

    static var allTests = [
        ("testPoint3", testPoint3),
        ("testBinaryTree", testBinaryTree),
        ("testColor", testColor),
        ("testASCII", testASCII),
    ]
}

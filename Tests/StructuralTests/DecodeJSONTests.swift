// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import XCTest

@testable import StructuralExamples

// This fails, likely due to a compiler bug (compiler can't
// prove that Struct<...> and Point3.Representation are the same)::
// 
// extension Point3: DecodeJSON {
//     public mutating func decodeJSON(from any: Any) {
//         var shape
//             : Struct<Field<Float, 
//                      Field<Float, 
//                      Field<Float,Empty>>>> 
//             = self.representation
//         shape.decodeJSON(from: any)
//         self = .init(representation: shape)
//     }
// }

// // A workaround for the failing canonical version above.
// extension Point3: DecodeJSON {
//     public mutating func decodeJSON(from any: Any) {
//         var shape = 
//             Struct("Point3", 
//                 Field("_1", _1, isMutable: true, 
//                 Field("_2", _2, isMutable: true,
//                 Field("_3", _3, isMutable: true, Empty()))))
// 
//         shape.decodeJSON(from: any)
// 
//         self._1 = shape.shape.value
//         self._2 = shape.shape.next.value
//         self._3 = shape.shape.next.next.value
//     }
// }

final class DecodeJSONTests: XCTestCase {
    // func testPoint3Shape() {
    //     let v: Float = 0
    //     var shape: Struct<Field<Float, 
    //                       Field<Float, 
    //                       Field<Float,Empty>>>> = 
    //         Struct("Point3", 
    //             Field("_1", v, isMutable: true, 
    //             Field("_2", v, isMutable: true,
    //             Field("_3", v, isMutable: true, Empty()))))
    //     decodeJSONString(from: "{\"_1\": 10.0, \"_2\": 20.0, \"_3\": 30.0}", into: &shape)
    //     XCTAssertEqual(shape.shape.value, 10.0) 
    //     XCTAssertEqual(shape.shape.next.value, 20.0) 
    //     XCTAssertEqual(shape.shape.next.next.value, 30.0) 
    // }

    func testArrayInt() {
        var arr: [Int] = []
        decodeJSONString(from: "[1, 2, 3]", into: &arr)
        XCTAssertEqual(arr, [1, 2, 3])
    }

    func testPoint3() {
        var point3 = Point3(_1: 0, _2: 0, _3: 0)
        decodeJSONString(from: "{\"_1\": 10.0, \"_2\": 20.0, \"_3\": 30.0}", into: &point3)
        XCTAssertEqual(point3._1, 10.0)
        XCTAssertEqual(point3._2, 20.0)
        XCTAssertEqual(point3._3, 30.0)
    }

    func testArrayPoint3() {
        var points: [Point3] = []
        decodeJSONString(from: "[{\"_1\": 10.0, \"_2\": 20.0, \"_3\": 30.0}]", into: &points)
        XCTAssertEqual(points.count, 1)
        XCTAssertEqual(points[0]._1, 10.0)
        XCTAssertEqual(points[0]._2, 20.0)
        XCTAssertEqual(points[0]._3, 30.0)
    }

    static var allTests = [
        ("testPoint3", testPoint3),
        ("testArrayInt", testArrayInt),
        ("testArrayPoint3", testArrayPoint3),
    ]
}

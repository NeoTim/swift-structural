import Benchmark
import GenericCore
import GenericExamples
import Foundation

let encodeJSONBenchmarks = BenchmarkSuite(name: "EncodeJSON") { suite in
    suite.benchmark("Point3 (generic)") {
        stringSink = toJSONString(p1)
    }

    suite.benchmark("Point3 (reference)") {
        let data = try! JSONEncoder().encode(p1)
        stringSink = String(data: data, encoding: .utf8)!
    }
}

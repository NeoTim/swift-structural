import Benchmark
import GenericCore
import GenericExamples
import Foundation

let hashableBenchmarks = BenchmarkSuite(name: "Hashable") { suite in
    suite.benchmark("Point3 (generic)") {
        intSink = genericHash(p1)
    }

    suite.benchmark("Point3 (reference)") {
        intSink = referenceHash(p1)
    }

    suite.benchmark("BinaryTree (generic)") {
        intSink = genericHash(tree1)
    }

    suite.benchmark("BinaryTree (reference)") {
        intSink = referenceHash(tree1)
    }

    suite.benchmark("Color (generic)") {
        intSink = genericHash(color1)
    }

    suite.benchmark("Color (reference)") {
        intSink = referenceHash(color1)
    }

    suite.benchmark("ASCII (generic)") {
        intSink = genericHash(ascii1)
    }

    suite.benchmark("ASCII (reference)") {
        intSink = referenceHash(ascii1)
    }
}

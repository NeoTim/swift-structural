import Benchmark
import GenericCore
import GenericExamples

var tree1: BinaryTree<Double> = .branch(.leaf(1), 2, .branch(.leaf(3), 4, .leaf(5)))
var tree2: BinaryTree<Double> = .branch(.leaf(10), 20, .branch(.leaf(30), 40, .leaf(50)))
var color1 = Color.red
var color2 = Color.blue
var ascii1 = ASCII.tab
var ascii2 = ASCII.lineFeed
var p1 = Point3(x: 10, y: 20, z: 30)
var p2 = Point3(x: 10, y: 20, z: 30)
var boolSink = false
var pointSink = p1
var treeSink = tree1
var stringSink = ""

Benchmark.main([
    additiveArithmeticBenchmarks,
    comparableBenchmarks,
    debugStringBenchmarks,
    encodeJSONBenchmarks,
])

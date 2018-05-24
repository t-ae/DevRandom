import XCTest
import DevRandom

class SingleNumberTests: XCTestCase {
    
    private func _test<T: FixedWidthInteger>(_ type: T.Type, file: StaticString = #file, line: UInt = #line) {
        
        let generateCount = 1000
        
        func _test(source: RandomNumberGenerator.Source) {
            guard let rng = RandomNumberGenerator(source: source) else {
                XCTFail("Failed to open \(source.path)", file: file, line: line)
                return
            }
            let numbers = (0..<generateCount).map { _ in rng.generate(UInt8.self) }
            XCTAssertGreaterThan(Set(numbers).count, 0, file: file, line: line)
        }
        _test(source: .random)
        _test(source: .urandom)
    }
    
    func testUInt8() {
        _test(UInt8.self)
    }
    
    func testUInt16() {
        _test(UInt16.self)
    }
    
    func testUInt32() {
        _test(UInt32.self)
    }
    
    func testUInt64() {
        _test(UInt64.self)
    }
    
    func testUInt() {
        _test(UInt.self)
    }
    
    func testInt8() {
        _test(Int8.self)
    }
    
    func testInt16() {
        _test(Int16.self)
    }
    
    func testInt32() {
        _test(Int32.self)
    }
    
    func testInt64() {
        _test(Int64.self)
    }
    
    func testInt() {
        _test(Int.self)
    }
    
    static var allTests = [
        ("testUInt8", testUInt8),
        ("testUInt16", testUInt16),
        ("testUInt32", testUInt32),
        ("testUInt64", testUInt64),
        ("testUInt", testUInt),
        ("testInt8", testInt8),
        ("testInt16", testInt16),
        ("testInt32", testInt32),
        ("testInt64", testInt64),
        ("testInt", testInt),
    ]

}

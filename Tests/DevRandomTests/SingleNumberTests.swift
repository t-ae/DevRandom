import XCTest
import DevRandom

class SingleNumberTests: XCTestCase {
    
    private func _test<T: FixedWidthInteger&UnsignedInteger>(_ type: T.Type, file: StaticString = #file, line: UInt = #line) {
        
        let generateCount = 1000
        
        func _test(source: DevRandom.Source) {
            guard let rng = try? DevRandom(source: source) else {
                XCTFail("Failed to open \(source.url)", file: file, line: line)
                return
            }
            var resultOr = T(0)
            var resultAnd = T.max
            for _ in 0..<10000 {
                resultOr |= rng.next() as T
                resultAnd &= rng.next() as T
            }
            XCTAssertEqual(resultOr, T.max)
            XCTAssertEqual(resultAnd, 0)
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
    
    static var allTests = [
        ("testUInt8", testUInt8),
        ("testUInt16", testUInt16),
        ("testUInt32", testUInt32),
        ("testUInt64", testUInt64),
        ("testUInt", testUInt),
    ]

}

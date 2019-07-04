import XCTest
import DevRandom

class DataTests: XCTestCase {

    func testData() throws {
        // urandom
        do {
            let rng = try DevRandom(source: .urandom)
            let data = rng.generate(count: 100)
            XCTAssertEqual(data.count, 100)
        }
        // random
        do {
            let rng = try DevRandom(source: .random)
            let data = rng.generate(count: 100)
            XCTAssertEqual(data.count, 100)
        }
    }
    
    func testNext() throws {
        // urandom
        do {
            let rng = try DevRandom(source: .urandom)
            let data = (0..<100).map { _ in rng.next() as UInt64 }
            XCTAssertEqual(Set(data).count, 100)
        }
        // urandom
        do {
            let rng = try DevRandom(source: .random)
            let data = (0..<100).map { _ in rng.next() as UInt64 }
            XCTAssertEqual(Set(data).count, 100)
        }
    }
    
    static var allTests = [
        ("testData", testData),
        ("testNext", testNext),
    ]
}

import XCTest
import DevRandom

class DataTests: XCTestCase {

    func testData() {
        // urandom
        if let rng = DevRandom(source: .urandom) {
            let data = rng.generate(count: 100)
            XCTAssertEqual(data.count, 100)
        } else {
            XCTFail("Failed to open /dev/urandom")
        }
        // random
        if let rng = DevRandom(source: .random) {
            let data = rng.generate(count: 100)
            XCTAssertEqual(data.count, 100)
        } else {
            XCTFail("Failed to open /dev/random")
        }
    }
    
    func testNext() {
        // urandom
        if let rng = DevRandom(source: .urandom) {
            let data = (0..<100).map { _ in rng.next() as UInt64 }
            XCTAssertEqual(Set(data).count, 100)
        } else {
            XCTFail("Failed to open /dev/urandom")
        }
        // uandom
        if let rng = DevRandom(source: .random) {
            let data = (0..<100).map { _ in rng.next() as UInt64 }
            XCTAssertEqual(Set(data).count, 100)
        } else {
            XCTFail("Failed to open /dev/urandom")
        }
    }
    
    static var allTests = [
        ("testData", testData),
    ]
}

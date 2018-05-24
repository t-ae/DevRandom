import XCTest
import DevRandom

class DataTests: XCTestCase {

    func testData() {
        // urandom
        if let rng = RandomNumberGenerator(source: .urandom) {
            let data = rng.generate(length: 100)
            XCTAssertEqual(data.count, 100)
        } else {
            XCTFail("Failed to open /dev/urandom")
        }
        // random
        if let rng = RandomNumberGenerator(source: .random) {
            let data = rng.generate(length: 100)
            XCTAssertEqual(data.count, 100)
        } else {
            XCTFail("Failed to open /dev/random")
        }
    }
    
    static var allTests = [
        ("testData", testData),
    ]
}

import XCTest
import DevRandom

final class DevRandomTests: XCTestCase {
    
    func testMultiple() {
        let rng1 = try! DevRandom(source: .random)
        let rng2 = try! DevRandom(source: .random)
        
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
    }
    
    func testSpeed() {
        let rng = try! DevRandom(source: .urandom)
        
        measure {
            var sum: UInt64 = 0
            for _ in 0..<100_000 {
                sum &+= rng.next()
            }
            XCTAssertTrue(sum > 0)
        }
    }
    
    func testSpeedSystemRNG() {
        var rng = SystemRandomNumberGenerator()
        
        measure {
            var sum: UInt64 = 0
            for _ in 0..<100_000 {
                sum &+= rng.next()
            }
            XCTAssertTrue(sum > 0)
        }
    }
    
    static var allTests = [
        ("testMultiple", testMultiple)
    ]
}

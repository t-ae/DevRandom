import XCTest
import DevRandom

final class DevRandomTests: XCTestCase {
    
    func testMultiple() {
        let rng1 = DevRandom(source: .random)
        let rng2 = DevRandom(source: .random)
        
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
    }
    
    func testClose() {
        let rng1: DevRandom
        
        do {
            let rng2 = DevRandom(source: .urandom)
            
            rng1 = rng2
        }
        
        let gotnonzero = (0..<100).map { _ in rng1.next() as UInt64 }.contains { $0 > 0 }
        XCTAssertTrue(gotnonzero)
    }
    
    func testSpeed() {
        let rng = DevRandom(source: .urandom)
        
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
        ("testMultiple", testMultiple),
        ("testClose", testClose)
    ]
}

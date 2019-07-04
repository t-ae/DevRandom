import XCTest
import DevRandom

final class DevRandomTests: XCTestCase {
    
    func testMultiple() {
        let rng1 = DevRandom(source: .random)!
        let rng2 = DevRandom(source: .random)!
        
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
        _ = rng1.next() as UInt64
        _ = rng2.next() as UInt64
    }
    
    static var allTests = [
        ("testMultiple", testMultiple)
    ]
}

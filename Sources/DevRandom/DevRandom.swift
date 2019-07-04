import Foundation

public struct DevRandom {
    public enum Source: String {
        case random, urandom
        public var url: URL {
            return URL(fileURLWithPath: "/dev/\(self.rawValue)")
        }
    }
    
    public let source: Source
    
    @usableFromInline
    let fileHandle: FileHandle
    
    @inlinable
    public init(source: Source) throws {
        let handle = try FileHandle(forReadingFrom: source.url)
        self.source = source
        self.fileHandle = handle
    }
}

extension DevRandom {
    @inlinable
    public func generate(count: Int) -> Data {
        return fileHandle.readData(ofLength: count)
    }
}

extension DevRandom: RandomNumberGenerator {
    @inlinable
    public func next() -> UInt64 {
        let data = generate(count: MemoryLayout<UInt64>.size)
        return data.withUnsafeBytes { (p: UnsafeRawBufferPointer) in
            p.bindMemory(to: UInt64.self)[0]
        }
    }
    
    
    @inlinable
    public func next<T>() -> T where T : FixedWidthInteger&UnsignedInteger {
        let (quotient, remainder) = T.bitWidth.quotientAndRemainder(dividingBy: UInt8.bitWidth)
        let data = generate(count: quotient + remainder.signum())
        
        return data.withUnsafeBytes { (p: UnsafeRawBufferPointer) in
            p.bindMemory(to: T.self)[0]
        }
    }
}

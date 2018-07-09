import Foundation

public final class DevRandom {
    
    public enum Source: String {
        case random, urandom
        public var path: String {
            return "/dev/\(self.rawValue)"
        }
    }
    
    public let source: Source
    private let fileHandle: FileHandle
    
    public init?(source: Source) {
        guard let handle = FileHandle(forReadingAtPath: source.path) else {
            return nil
        }
        self.source = source
        self.fileHandle = handle
    }
}

extension DevRandom {
    public func generate(count: Int) -> Data {
        return fileHandle.readData(ofLength: count)
    }
}

extension DevRandom: RandomNumberGenerator {
    public func next<T>() -> T where T : FixedWidthInteger, T : UnsignedInteger {
        let (quotient, remainder) = T.bitWidth.quotientAndRemainder(dividingBy: UInt8.bitWidth)
        return generate(count: quotient + remainder.signum()).withUnsafeBytes { (p: UnsafePointer<T>) in
            p.pointee
        }
    }
}

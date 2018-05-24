import Foundation

public final class RandomNumberGenerator {
    
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

extension RandomNumberGenerator {
    public func generate(count: Int) -> Data {
        return fileHandle.readData(ofLength: count)
    }
    
    public func generate<T: FixedWidthInteger>(_ type: T.Type = T.self) -> T {
        return generate(count: MemoryLayout<T>.size).withUnsafeBytes { p in
            p.pointee
        }
    }
}

import Foundation

public final class RandomNumberGenerator {
    
    public enum Source: String {
        case random, urandom
        public var path: String {
            return "/dev/\(self.rawValue)"
        }
    }
    
    private let fileHandle: FileHandle
    
    public init?(source: Source) {
        guard let handle = FileHandle(forReadingAtPath: source.path) else {
            return nil
        }
        
        self.fileHandle = handle
    }
}

extension RandomNumberGenerator {
    public func generate(length: Int) -> Data {
        return fileHandle.readData(ofLength: length)
    }
    
    public func generate<T: FixedWidthInteger>(_ type: T.Type = T.self) -> T {
        return generate(length: MemoryLayout<T>.size).withUnsafeBytes { p in
            p.pointee
        }
    }
}

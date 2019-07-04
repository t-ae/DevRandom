import Foundation

@usableFromInline
class Reader {
    @usableFromInline
    let descriptor: Int32
    
    @inlinable
    init(url: URL) {
        assert(url.isFileURL)
        
        descriptor = open(url.path, O_RDONLY)
        precondition(descriptor != -1, "Failed to open: url=\(url), errno=\(errno)")
    }
    
    @inlinable
    deinit {
        let result = close(descriptor)
        precondition(result != -1, "Failed to close: errno=\(errno)")
    }
    
    @inlinable
    func read(pointer: UnsafeMutableRawPointer, count: Int) {
        Foundation.read(descriptor, pointer, count)
    }
}

public struct DevRandom {
    public enum Source: String {
        case random, urandom
        public var url: URL {
            return URL(fileURLWithPath: "/dev/\(self.rawValue)")
        }
    }
    
    public let source: Source
    
    @usableFromInline
    let reader: Reader
    
    @inlinable
    public init(source: Source) {
        self.source = source
        self.reader = Reader(url: source.url)
    }
}

extension DevRandom {
    @inlinable
    public func generate(count: Int) -> Data {
        var bytes = [UInt8](repeating: 0, count: count)
        reader.read(pointer: &bytes, count: count)
        return Data(bytes)
    }
}

extension DevRandom: RandomNumberGenerator {
    @inlinable
    public func next<T>() -> T where T : FixedWidthInteger&UnsignedInteger {
        var uint: T = 0
        reader.read(pointer: &uint, count: MemoryLayout<T>.size)
        return uint
    }
}

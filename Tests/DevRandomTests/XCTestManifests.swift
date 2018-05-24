import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DevRandomTests.allTests),
        testCase(SingleNumberTests.allTests),
        testCase(DataTests.allTests),
    ]
}
#endif

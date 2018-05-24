import XCTest

import dev_randomTests

var tests = [XCTestCaseEntry]()
tests += dev_randomTests.allTests()
XCTMain(tests)
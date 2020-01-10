import XCTest

import serv2Tests

var tests = [XCTestCaseEntry]()
tests += serv2Tests.allTests()
XCTMain(tests)

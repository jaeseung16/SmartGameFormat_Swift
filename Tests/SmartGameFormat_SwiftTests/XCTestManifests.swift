import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SmartGameFormat_SwiftTests.allTests),
    ]
}
#endif

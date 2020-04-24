import XCTest

#if !canImport(ObjectiveC)
/// Lists all the available tests
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FuzzyTestsTests.allTests)
    ]
}
#endif

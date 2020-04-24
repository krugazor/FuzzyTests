import XCTest
import HoledRange
@testable import FuzzyTests

final class FuzzyTestsTests: XCTestCase {
    func testExample() {
        let testTFR = DomainTests<Int> {
            Domain(1...10)
            5
            Test { (input: Int) in
                print("t1 \(input)")
                XCTAssert(input >= 1 && input <= 10)
            }
            Test { (input: Int) in
                print("t2 \(input)")
                XCTAssert(input >= 1 && input <= 10)
            }
        }
        
        testTFR.random()
        testTFR.full()
    }
    
    func testStrings() {
        var count = 0
        DomainTests<String> {
            Domain("AAA"..."zzz")
            50
            Test { (inputStr: String) in
                count += 1
                XCTAssert(inputStr.capitalized.count == inputStr.count)
            }
            Test { (inputStr: String) in
                count += 1
                XCTAssert(inputStr.lowercased().count == inputStr.count)
            }
            Test { inputStr in
                XCTAssertFalse(inputStr == "no")
            }
        }.random()
        print("Tested \(count)")
    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testExample", testStrings)
    ]
}

# FuzzyTests

Function builder - based system to enable domain testing, either randomly or sequentially.

Under Apache2 license.

### Usage

Include the package in your dependencies in your `Package.swift`:

```swift
dependencies: [
    // ...
    .package(url: "https://github.com/krugazor/FuzzyTests", from: "0.1.0")
    ]
```

Then add it to your *test* target:

```swift
.testTarget(
    name: "DomainTestExampleTests",
    dependencies: ["DomainTestExample", "FuzzyTests"])
```

Then you can use it in your test classes:

```swift
import XCTest
import FuzzyTests
import HoledRange

@testable import DomainTestExample

final class DomainTestExampleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        DomainTests<String> {
            Domain("AAA"..."zzz")
            2000
            Test { (s: String) in
                print(s)
                XCTAssertNotEqual("Hello there", s)
            }
        }.random()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

```

### Details

The random (or full) tests are built using function builders that take at least 2 parameters: the domain and one function to test. Optionally, the function buider can use an int to represent the number of samples to take from the domain.

Each test has exactly *one* variable that moves across the domain, thus necessitating a specific type.

Finally, you can call `random()` to test randomly across the domain, and if the type is `Strideable` (that is can be used in a for loop, more or less), you can test with every value in the domain.

#### Example: testing A+B (plus function)

Here's a silly example.

Let's imagine I have a function that is defined like this:

```swift
func myPlus(_ a: Int, _ b: Int) -> Int
```

I want to test that `myPlus(x,y)` is equal to `x+y` because I don't trust the implementation, which I can't see. Let's build the tests:

```swift
DomainTests<Int> {
    Domain(-10000...10000)
    1000000
    Test { (a: Int) in
        XCTAssert(myPlus(a, 1) == a+1, "Problem with value\(a)")
        XCTAssert(myPlus(1, a) == a+1, "Problem with value\(a)")
    }
    Test { (a: Int) in
        let random = Int.random(in: -10000...10000)
        XCTAssert(myPlus(a, random) == a+random, "Problem with value\(a)")
        XCTAssert(myPlus(random, a) == a+random, "Problem with value\(a)")
   }
}.random()
```

This will test that `myPlus` is somewhat consistent across the board. Of course, it doesn't test *everything*, just the bits I care about (reflexivity and some random ranges).

Because `Int` is `Strideable`, I can test the whole range, rather than a random sampling:

```swift
DomainTests<Int> {
    Domain(-10000...10000)
    Test { (a: Int) in
        XCTAssert(myPlus(a, 1) == a+1, "Problem with value\(a)")
        XCTAssert(myPlus(1, a) == a+1, "Problem with value\(a)")
    }
    Test { (a: Int) in
        let random = Int.random(in: -10000...10000)
        XCTAssert(myPlus(a, random) == a+random, "Problem with value\(a)")
        XCTAssert(myPlus(random, a) == a+random, "Problem with value\(a)")
   }
}.full()
```

### PR(S) Accepted!

Please check that `swift run FTLint`, `swift test`, and `swift run FTDocs` don't return anything untoward beforehand

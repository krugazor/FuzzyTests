import Foundation
import XCTest
import HoledRange

// MARK: -
// MARK: Testable Functions

/// Alias to avoid parsing and typing issues with the arrow
public typealias TestableFunction<T> = (T) -> Void where T: Hashable, T: Randomizable

/// Protocol used for types that can test random values in a domain
protocol TestableFunctionOverDomainRandomly {
    /// Performs a test randomly over a domain
    /// - parameter over: the domain to test over
    /// - parameter count: the number of tests to perform
    func testRandom<T>(over: Domain<T>, count: Int) where T: Hashable, T: Randomizable
}

/// Protocol used for types that can test sequential values in a domain
protocol TestableFunctionOverDomainSequentially {
    /// Performs a test sequentially over an entire domain
    /// - parameter over: the domain to test over
    func testFull<T>(over: Domain<T>) where T: Hashable, T: Randomizable, T: Strideable, T.Stride: SignedInteger
}

/// Wrapper around a function that should be tested at least randomly over a domain
/// - note: because of type constraints in domains, most of the classes are generics
public class SingleTestableFunction<Input> : TestableFunctionOverDomainRandomly where
    Input: Hashable,
Input: Randomizable {
    /// The tested function
    let function : TestableFunction<Input>
    
    /// Default initializer that takes a function as a parameter
    /// - parameter inFunc: the function to test, which *must* take exactly one (variable) input
    public init(_ inFunc: @escaping TestableFunction<Input>) {
        function = inFunc
    }
    
    /// Implementation of the random testing
    /// - parameter over: the domain to test over
    /// - parameter count: the number of tests to perform
    /// - see: protocol TestableFunctionOverDomainRandomly
    public func testRandom<T>(over: Domain<T>, count: Int) where T: Hashable, T: Randomizable {
        guard T.self == Input.self else { XCTFail("Cannot test dissimilar types") ; return }
        for _ in 0..<count {
            if let variable = over.randomElement() as? Input { function(variable) }
        }
    }
}

/// Extension, in case `Input` is also capable of sequential testing
extension SingleTestableFunction : TestableFunctionOverDomainSequentially where
    Input: Strideable,
Input.Stride : SignedInteger {
    /// Implementation of the sequential testing
    /// - parameter over: the domain to test over
    /// - see: protocol TestableFunctionOverDomainSequentially
    func testFull<T>(over: HoledRange<T>) where T: Hashable, T: Randomizable, T: Strideable, T.Stride: SignedInteger {
        guard T.self == Input.self else { XCTFail("Cannot test dissimilar types") ; return }
        for variable in over {
            if let variable = variable as? Input {
                function(variable)
            }
        }
    }
}

/// Package class collecting multiple testable functions
class CompoundTestableFunction<Input> : TestableFunctionOverDomainRandomly where Input: Hashable, Input: Randomizable {
    /// The functions to be tested
    let functions : [TestableFunction<Input>]
    
    /// Default initializer, no function tested
    init() {
        functions = []
    }
    
    /// Initializer that takes a function as a parameter
    /// - parameter inFunc: the function to test, which *must* take exactly one (variable) input
    init(_ inFunc: @escaping TestableFunction<Input>) {
        functions = [inFunc]
    }
    
    /// Initializer that takes a function as a parameter
    /// - parameter inFuncs: the functions to test, which *must* take exactly one (variable) input, variadic version
    init(_ inFuncs: TestableFunction<Input>...) {
        functions = inFuncs
    }
    
    /// Initializer that takes a testable function as a parameter
    /// - parameter inTFunc: matching testable function object
    init(_ inTFunc : SingleTestableFunction<Input>) {
        functions = [inTFunc.function]
    }
    
    /// Initializer that takes testable functions as a parameter
    /// - parameter inTFuncs: matching testable function objects, variadic version
    init(_ inTFuncs : SingleTestableFunction<Input>...) {
        functions = inTFuncs.map { $0.function }
    }
    
    /// Initializer that takes testable functions as a parameter
    /// - parameter inTFuncs: matching testable function objects, array version
    init(_ inTFuncs : [SingleTestableFunction<Input>]) {
        functions = inTFuncs.map { $0.function }
    }
    
    /// Initializer that takes compound testable functions as a parameter
    /// - parameter inTFuncs: matching compound testable function object
    init(_ inCFunc : CompoundTestableFunction<Input>) {
        functions = inCFunc.functions
    }
    
    /// Initializer that takes compound testable functions as a parameter
    /// - parameter inTFuncs: matching compound testable function objects in variadic form
    init(_ inCFuncs : CompoundTestableFunction<Input>...) {
        functions = inCFuncs.flatMap { $0.functions }
    }
    
    /// Initializer that all possible variants as parameters used with the function builders
    /// - parameter compounds: matching compound testable function objects
    /// - parameter singles: matching testable function objects
    /// - parameter functions: the functions to test, which *must* take exactly one (variable) input
    init(
        compounds: [CompoundTestableFunction<Input>] = [],
        singles: [SingleTestableFunction<Input>] = [],
        functions inFuncs: [TestableFunction<Input>] = []) {
        functions = compounds.flatMap { $0.functions } + singles.map { $0.function } + inFuncs
    }
    
    /// Implementation of the random testing
    /// - parameter over: the domain to test over
    /// - parameter count: the number of tests to perform
    /// - see: protocol TestableFunctionOverDomainRandomly
    func testRandom<T>(over: HoledRange<T>, count: Int) where T: Hashable, T: Randomizable {
        guard T.self == Input.self else { XCTFail("Cannont test dissimilar types") ; return }
        for function in functions {
            for _ in 0..<count {
                if let variable = over.randomElement() as? Input { function(variable) }
            }
        }
    }
}

// Extension, in case `Input` is also capable of sequential testing
extension CompoundTestableFunction : TestableFunctionOverDomainSequentially where
    Input: Strideable,
Input.Stride : SignedInteger {
    /// Implementation of the sequential testing
    /// - parameter over: the domain to test over
    /// - see: protocol TestableFunctionOverDomainSequentially
    func testFull<T>(over: Domain<T>) where
        T: Hashable,
        T: Randomizable,
        T: Strideable,
        T.Stride: SignedInteger {
            guard T.self == Input.self else { XCTFail("Cannont test dissimilar types") ; return }
            for function in functions {
                for variable in over {
                    if let variable = variable as? Input { function(variable) }
                }
            }
    }
}

/// Wrapper around CompoundTestableFunction for function builder needs
struct TestableFunctions<T> : TestableFunctionOverDomainRandomly where T: Hashable, T: Randomizable {
    /// the consolidated functions to test
    let functions : CompoundTestableFunction<T>
    
    /// Default initialization
    /// - parameter functions: the functions to test
    init(functions inFunctions: CompoundTestableFunction<T>) {
        functions = inFunctions
    }
    
    /// Function builder initialization
    /// - parameter content: the function builder assembly
    init(@TestableFunctionBuilder<T> _ content: () -> TestableFunctionOverDomainRandomly) {
        let assembly = content()
        if let compound = assembly as? CompoundTestableFunction<T> { functions = compound }
        else if let single = assembly as? SingleTestableFunction<T> { functions = CompoundTestableFunction(single) }
        else { functions = CompoundTestableFunction<T>() }
    }
    
    /// Implementation of the random testing
    /// - parameter over: the domain to test over
    /// - parameter count: the number of tests to perform
    /// - see: protocol TestableFunctionOverDomainRandomly
    func testRandom<T>(over: Domain<T>, count: Int) where T : Randomizable, T : Hashable {
        functions.testRandom(over: over, count: count)
    }
}

// Extension, in case `T` is also capable of sequential testing
extension TestableFunctions : TestableFunctionOverDomainSequentially where T: Strideable, T.Stride: SignedInteger {
    /// Implementation of the sequential testing
    /// - parameter over: the domain to test over
    /// - see: protocol TestableFunctionOverDomainSequentially
    func testFull<T>(over: HoledRange<T>) where
        T : Randomizable,
        T : Hashable,
        T : Strideable,
        T.Stride : SignedInteger {
            functions.testFull(over: over)
    }
}

// MARK: -
// MARK: Domain Tests

/// Main class for the package, assembles the functions, the domain to test over and the number of tests to perform
public class DomainTests<T> where T: Hashable, T: Randomizable {
    /// Function holder
    let testableFunctions : TestableFunctions<T>
    /// Testing domain
    let domain: Domain<T>
    /// Number of tests to perform. 20 by default
    let iterations : Int?
    
    /// Full initializer with all the parts
    /// - parameter functions: the functions to test
    /// - parameter over: the domain to test over
    /// - parameter count: the number of tests to perform
    init(functions: TestableFunctions<T>, over: Domain<T>, count: Int? = nil) {
        testableFunctions = functions
        domain = over
        iterations = count
    }
    
    /// Function builder initializer
    /// - parameter content: the function builder assembly
    public init(@DomainTestsBuilder<T> _ content: () -> DomainTests<T>) {
        let tests = content()
        testableFunctions = tests.testableFunctions
        domain = tests.domain
        iterations = tests.iterations
    }
    
    /// Performs random tests based on the instance variables
    public func random() {
        random(count: nil, domOverride: nil)
    }
    
    /// Used for (unfinished) domain narrowing testing
    /// - parameter count: number if tests to do, defaults to 20
    /// - parameter domOverride: overrides the domain for testing
    func random(count : Int? = nil, domOverride: Domain<T>? = nil) {
        let icount = (count ?? iterations ?? 20) // 20 by default
        testableFunctions.testRandom(over: domOverride ?? domain, count: icount)
    }
}

// Extension, in case `T` is also capable of sequential testing
public extension DomainTests where T: Strideable, T.Stride: SignedInteger {
    /// Full test over all the elements in the domain
    func full() {
        full(domOverride: nil)
    }
    
    /// Used for (unfinished) domain narrowing testing
    /// - parameter domOverride: overrides the domain for testing
    private func full(domOverride: Domain<T>? = nil) {
        testableFunctions.testFull(over: domOverride ?? domain)
    }
}

// MARK: -
// MARK: Function Builders

/// Protocol for syntax purposes, allows all the elements to be present
public protocol DomainTestsElement { }

/// Make `Domain` usable in the function builder
extension Domain : DomainTestsElement { }
/// Make `SingleTestableFunction` usable in the function builder
extension SingleTestableFunction : DomainTestsElement { }
/// Make `Int` usable in the function builder
extension Int : DomainTestsElement { }
/// For clarity, use `Test` instead of the longer form
public typealias Test = SingleTestableFunction

/// Function builder that assembles testable functions (and compounds) into a single compound function
@_functionBuilder
public class TestableFunctionBuilder<T> where T: Hashable, T: Randomizable {
    /// override that assembles blocks of type `TestableFunctionOverDomainXXX` into a single `CompoundTestableFunction`
    static func buildBlock<U : TestableFunctionOverDomainRandomly>(_ children: U...) -> CompoundTestableFunction<T> {
        if children.count == 1 {
            if let child = children[0] as? SingleTestableFunction<T> { return CompoundTestableFunction(child) }
            else if let child = children[0] as? CompoundTestableFunction<T> { return child }
            else { return CompoundTestableFunction<T>() }
        } else {
            let compounds = children.compactMap { $0 as? CompoundTestableFunction<T> }
            let singles = children.compactMap { $0 as? SingleTestableFunction<T> }
            return CompoundTestableFunction<T>(compounds: compounds, singles: singles)
        }
    }
}

/// Function builder that assembles testable functions (and compounds), a domain and an int into a `DomainTests`
@_functionBuilder
public struct DomainTestsBuilder<T> where T: Hashable, T: Randomizable {
    /// override that assembles blocks together into a test
    public static func buildBlock(_ children: DomainTestsElement...) -> DomainTests<T> {
        guard let domain = (children.first(where: { $0 is Domain<T> }) as? Domain<T>) else {
            fatalError("No test domain provided")
        }
        let iterations = (children.first(where: { $0 is Int }) as? Int)
        let funcs = children.compactMap({ $0 as? SingleTestableFunction<T> })
        let tfuncs = TestableFunctions(functions: CompoundTestableFunction(funcs))
        return DomainTests(functions: tfuncs, over: domain, count: iterations)
    }
}

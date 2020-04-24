**CLASS**

# `SingleTestableFunction`

**Contents**

- [Properties](#properties)
  - `function`
- [Methods](#methods)
  - `init(_:)`
  - `testRandom(over:count:)`

```swift
public class SingleTestableFunction<Input> : TestableFunctionOverDomainRandomly where
    Input: Hashable,
Input: Randomizable
```

> Wrapper around a function that should be tested at least randomly over a domain
> - note: because of type constraints in domains, most of the classes are generics

## Properties
### `function`

```swift
let function : TestableFunction<Input>
```

> The tested function

## Methods
### `init(_:)`

```swift
public init(_ inFunc: @escaping TestableFunction<Input>)
```

> Default initializer that takes a function as a parameter
> - parameter inFunc: the function to test, which *must* take exactly one (variable) input

#### Parameters

| Name | Description |
| ---- | ----------- |
| inFunc | the function to test, which  take exactly one (variable) input |

### `testRandom(over:count:)`

```swift
public func testRandom<T>(over: Domain<T>, count: Int) where T: Hashable, T: Randomizable
```

> Implementation of the random testing
> - parameter over: the domain to test over
> - parameter count: the number of tests to perform
> - see: protocol TestableFunctionOverDomainRandomly

#### Parameters

| Name | Description |
| ---- | ----------- |
| over | the domain to test over |
| count | the number of tests to perform |
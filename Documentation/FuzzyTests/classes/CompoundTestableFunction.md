**CLASS**

# `CompoundTestableFunction`

**Contents**

- [Properties](#properties)
  - `functions`
- [Methods](#methods)
  - `init()`
  - `init(_:)`
  - `init(_:)`
  - `init(_:)`
  - `init(_:)`
  - `init(_:)`
  - `init(_:)`
  - `init(_:)`
  - `init(compounds:singles:functions:)`
  - `testRandom(over:count:)`

```swift
class CompoundTestableFunction<Input> : TestableFunctionOverDomainRandomly where Input: Hashable, Input: Randomizable
```

> Package class collecting multiple testable functions

## Properties
### `functions`

```swift
let functions : [TestableFunction<Input>]
```

> The functions to be tested

## Methods
### `init()`

```swift
init()
```

> Default initializer, no function tested

### `init(_:)`

```swift
init(_ inFunc: @escaping TestableFunction<Input>)
```

> Initializer that takes a function as a parameter
> - parameter inFunc: the function to test, which *must* take exactly one (variable) input

#### Parameters

| Name | Description |
| ---- | ----------- |
| inFunc | the function to test, which  take exactly one (variable) input |

### `init(_:)`

```swift
init(_ inFuncs: TestableFunction<Input>...)
```

> Initializer that takes a function as a parameter
> - parameter inFuncs: the functions to test, which *must* take exactly one (variable) input, variadic version

#### Parameters

| Name | Description |
| ---- | ----------- |
| inFuncs | the functions to test, which  take exactly one (variable) input, variadic version |

### `init(_:)`

```swift
init(_ inTFunc : SingleTestableFunction<Input>)
```

> Initializer that takes a testable function as a parameter
> - parameter inTFunc: matching testable function object

#### Parameters

| Name | Description |
| ---- | ----------- |
| inTFunc | matching testable function object |

### `init(_:)`

```swift
init(_ inTFuncs : SingleTestableFunction<Input>...)
```

> Initializer that takes testable functions as a parameter
> - parameter inTFuncs: matching testable function objects, variadic version

#### Parameters

| Name | Description |
| ---- | ----------- |
| inTFuncs | matching testable function objects, variadic version |

### `init(_:)`

```swift
init(_ inTFuncs : [SingleTestableFunction<Input>])
```

> Initializer that takes testable functions as a parameter
> - parameter inTFuncs: matching testable function objects, array version

#### Parameters

| Name | Description |
| ---- | ----------- |
| inTFuncs | matching testable function objects, array version |

### `init(_:)`

```swift
init(_ inCFunc : CompoundTestableFunction<Input>)
```

> Initializer that takes compound testable functions as a parameter
> - parameter inTFuncs: matching compound testable function object

#### Parameters

| Name | Description |
| ---- | ----------- |
| inTFuncs | matching compound testable function object |

### `init(_:)`

```swift
init(_ inCFuncs : CompoundTestableFunction<Input>...)
```

> Initializer that takes compound testable functions as a parameter
> - parameter inTFuncs: matching compound testable function objects in variadic form

#### Parameters

| Name | Description |
| ---- | ----------- |
| inTFuncs | matching compound testable function objects in variadic form |

### `init(compounds:singles:functions:)`

```swift
init(
    compounds: [CompoundTestableFunction<Input>] = [],
    singles: [SingleTestableFunction<Input>] = [],
    functions inFuncs: [TestableFunction<Input>] = [])
```

> Initializer that all possible variants as parameters used with the function builders
> - parameter compounds: matching compound testable function objects
> - parameter singles: matching testable function objects
> - parameter functions: the functions to test, which *must* take exactly one (variable) input

#### Parameters

| Name | Description |
| ---- | ----------- |
| compounds | matching compound testable function objects |
| singles | matching testable function objects |
| functions | the functions to test, which  take exactly one (variable) input |

### `testRandom(over:count:)`

```swift
func testRandom<T>(over: HoledRange<T>, count: Int) where T: Hashable, T: Randomizable
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
**STRUCT**

# `TestableFunctions`

**Contents**

- [Properties](#properties)
  - `functions`
- [Methods](#methods)
  - `init(functions:)`
  - `init(_:)`
  - `testRandom(over:count:)`

```swift
struct TestableFunctions<T> : TestableFunctionOverDomainRandomly where T: Hashable, T: Randomizable
```

> Wrapper around CompoundTestableFunction for function builder needs

## Properties
### `functions`

```swift
let functions : CompoundTestableFunction<T>
```

> the consolidated functions to test

## Methods
### `init(functions:)`

```swift
init(functions inFunctions: CompoundTestableFunction<T>)
```

> Default initialization
> - parameter functions: the functions to test

#### Parameters

| Name | Description |
| ---- | ----------- |
| functions | the functions to test |

### `init(_:)`

```swift
init(@TestableFunctionBuilder<T> _ content: () -> TestableFunctionOverDomainRandomly)
```

> Function builder initialization
> - parameter content: the function builder assembly

#### Parameters

| Name | Description |
| ---- | ----------- |
| content | the function builder assembly |

### `testRandom(over:count:)`

```swift
func testRandom<T>(over: Domain<T>, count: Int) where T : Randomizable, T : Hashable
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
**CLASS**

# `DomainTests`

**Contents**

- [Properties](#properties)
  - `testableFunctions`
  - `domain`
  - `iterations`
- [Methods](#methods)
  - `init(functions:over:count:)`
  - `init(_:)`
  - `random()`
  - `random(count:domOverride:)`

```swift
public class DomainTests<T> where T: Hashable, T: Randomizable
```

> Main class for the package, assembles the functions, the domain to test over and the number of tests to perform

## Properties
### `testableFunctions`

```swift
let testableFunctions : TestableFunctions<T>
```

> Function holder

### `domain`

```swift
let domain: Domain<T>
```

> Testing domain

### `iterations`

```swift
let iterations : Int?
```

> Number of tests to perform. 20 by default

## Methods
### `init(functions:over:count:)`

```swift
init(functions: TestableFunctions<T>, over: Domain<T>, count: Int? = nil)
```

> Full initializer with all the parts
> - parameter functions: the functions to test
> - parameter over: the domain to test over
> - parameter count: the number of tests to perform

#### Parameters

| Name | Description |
| ---- | ----------- |
| functions | the functions to test |
| over | the domain to test over |
| count | the number of tests to perform |

### `init(_:)`

```swift
public init(@DomainTestsBuilder<T> _ content: () -> DomainTests<T>)
```

> Function builder initializer
> - parameter content: the function builder assembly

#### Parameters

| Name | Description |
| ---- | ----------- |
| content | the function builder assembly |

### `random()`

```swift
public func random()
```

> Performs random tests based on the instance variables

### `random(count:domOverride:)`

```swift
func random(count : Int? = nil, domOverride: Domain<T>? = nil)
```

> Used for (unfinished) domain narrowing testing
> - parameter count: number if tests to do, defaults to 20
> - parameter domOverride: overrides the domain for testing

#### Parameters

| Name | Description |
| ---- | ----------- |
| count | number if tests to do, defaults to 20 |
| domOverride | overrides the domain for testing |
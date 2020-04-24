**PROTOCOL**

# `TestableFunctionOverDomainRandomly`

```swift
protocol TestableFunctionOverDomainRandomly
```

> Protocol used for types that can test random values in a domain

## Methods
### `testRandom(over:count:)`

```swift
func testRandom<T>(over: Domain<T>, count: Int) where T: Hashable, T: Randomizable
```

> Performs a test randomly over a domain
> - parameter over: the domain to test over
> - parameter count: the number of tests to perform

#### Parameters

| Name | Description |
| ---- | ----------- |
| over | the domain to test over |
| count | the number of tests to perform |
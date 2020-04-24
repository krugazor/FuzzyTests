**PROTOCOL**

# `TestableFunctionOverDomainSequentially`

```swift
protocol TestableFunctionOverDomainSequentially
```

> Protocol used for types that can test sequential values in a domain

## Methods
### `testFull(over:)`

```swift
func testFull<T>(over: Domain<T>) where T: Hashable, T: Randomizable, T: Strideable, T.Stride: SignedInteger
```

> Performs a test sequentially over an entire domain
> - parameter over: the domain to test over

#### Parameters

| Name | Description |
| ---- | ----------- |
| over | the domain to test over |
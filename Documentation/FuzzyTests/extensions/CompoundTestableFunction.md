**EXTENSION**

# `CompoundTestableFunction`
```swift
extension CompoundTestableFunction : TestableFunctionOverDomainSequentially where
    Input: Strideable,
Input.Stride : SignedInteger
```

## Methods
### `testFull(over:)`

```swift
func testFull<T>(over: Domain<T>) where
    T: Hashable,
    T: Randomizable,
    T: Strideable,
    T.Stride: SignedInteger
```

> Implementation of the sequential testing
> - parameter over: the domain to test over
> - see: protocol TestableFunctionOverDomainSequentially

#### Parameters

| Name | Description |
| ---- | ----------- |
| over | the domain to test over |
**EXTENSION**

# `SingleTestableFunction`
```swift
extension SingleTestableFunction : TestableFunctionOverDomainSequentially where
    Input: Strideable,
Input.Stride : SignedInteger
```

## Methods
### `testFull(over:)`

```swift
func testFull<T>(over: HoledRange<T>) where T: Hashable, T: Randomizable, T: Strideable, T.Stride: SignedInteger
```

> Implementation of the sequential testing
> - parameter over: the domain to test over
> - see: protocol TestableFunctionOverDomainSequentially

#### Parameters

| Name | Description |
| ---- | ----------- |
| over | the domain to test over |
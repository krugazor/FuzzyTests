**EXTENSION**

# `TestableFunctions`
```swift
extension TestableFunctions : TestableFunctionOverDomainSequentially where T: Strideable, T.Stride: SignedInteger
```

## Methods
### `testFull(over:)`

```swift
func testFull<T>(over: HoledRange<T>) where
    T : Randomizable,
    T : Hashable,
    T : Strideable,
    T.Stride : SignedInteger
```

> Implementation of the sequential testing
> - parameter over: the domain to test over
> - see: protocol TestableFunctionOverDomainSequentially

#### Parameters

| Name | Description |
| ---- | ----------- |
| over | the domain to test over |
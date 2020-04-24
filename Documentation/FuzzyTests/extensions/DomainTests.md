**EXTENSION**

# `DomainTests`
```swift
public extension DomainTests where T: Strideable, T.Stride: SignedInteger
```

## Methods
### `full()`

```swift
func full()
```

> Full test over all the elements in the domain

### `full(domOverride:)`

```swift
private func full(domOverride: Domain<T>? = nil)
```

> Used for (unfinished) domain narrowing testing
> - parameter domOverride: overrides the domain for testing

#### Parameters

| Name | Description |
| ---- | ----------- |
| domOverride | overrides the domain for testing |
**CLASS**

# `TestableFunctionBuilder`

**Contents**

- [Methods](#methods)
  - `buildBlock(_:)`

```swift
public class TestableFunctionBuilder<T> where T: Hashable, T: Randomizable
```

> Function builder that assembles testable functions (and compounds) into a single compound function

## Methods
### `buildBlock(_:)`

```swift
static func buildBlock<U : TestableFunctionOverDomainRandomly>(_ children: U...) -> CompoundTestableFunction<T>
```

> override that assembles blocks of type `TestableFunctionOverDomainXXX` into a single `CompoundTestableFunction`

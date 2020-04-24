**STRUCT**

# `DomainTestsBuilder`

**Contents**

- [Methods](#methods)
  - `buildBlock(_:)`

```swift
public struct DomainTestsBuilder<T> where T: Hashable, T: Randomizable
```

> Function builder that assembles testable functions (and compounds), a domain and an int into a `DomainTests`

## Methods
### `buildBlock(_:)`

```swift
public static func buildBlock(_ children: DomainTestsElement...) -> DomainTests<T>
```

> override that assembles blocks together into a test

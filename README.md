# Either

This is a Swift microframework providing `Either<Left, Right>` and `EitherType`, with generic implementations of `==`/`!=` where `Left` & `Right`: `Equatable`.

`Either` allows you to specify that a value should be one of two types, or that that a value of a single type should have one of two semantics. For example, `Either<Int, NSError>` might be the result of a computation which could fail, while `Either<String, String>` might mean that you want to handle a string in one of two different ways.

`EitherType` is an easy-to-adopt protocol (it requires one method and two constructor functions) which allows clients to generically use `Either` or conforming `Result`, etc. types.


## Use

Constructing an `Either`:

```swift
// Wrap:
let left = Either<Int, String>.left(4)
let right = Either<Int, String>.right("four")
```

Extracting the value:

```swift
// Unwrap:
let value = left.either({ x in x }, { string in countElements(string) })
```


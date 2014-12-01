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

Representing success/failure:

```swift
let result = someComputation() // result has type `Either<Error, T>`
let success = result.either({ _ in nil }, { x in x }) // success has type `T?`
let error = result.either({ x in x }, { _ in nil }) // error has type `Error?`
```

However, you might instead prefer to use a [more tailored `Result`](https://github.com/LlamaKit/LlamaKit) type. Even if it doesn’t conform to `EitherType` already, you can implement conformance in your application:

```swift
extension Result: EitherType { // Result<T, Error>
	static func left(value: Error) -> Result {
		return failure(value)
	}

	static func right(value: T) -> Result {
		return success(value)
	}

	func either<Result>(f: Error -> Result, g: T -> Result) -> Result {
		switch self {
		case let Success(x):
			return g(x)
		case let Failure(error):
			return f(error)
		}
	}
}
```

Now you can use generic functions like `==`, `!=`, and any you might write with both `Either` and `Result`.

API documentation is in the source.


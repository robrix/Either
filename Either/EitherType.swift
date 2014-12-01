//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A type representing an alternative of one of two types.
///
/// By convention, and where applicable, `Left` is used to indicate failure, while `Right` is to indicate success. (Mnemonic: “right is right,” i.e. “right” is a synonym for “correct.”)
///
/// Otherwise it is implied that `Left` and `Right` are effectively unordered.
public protocol EitherType {
	typealias Left
	typealias Right

	/// Constructs a `Left` instance.
	class func left(value: Left) -> Self

	/// Constructs a `Right` instance.
	class func right(value: Right) -> Self

	/// Returns the result of applying `f` to `Left` values, or `g` to `Right` values.
	func either<Result>(f: Left -> Result, _ g: Right -> Result) -> Result
}


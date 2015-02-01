//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A type representing an alternative of one of two types.
///
/// By convention, and where applicable, `Left` is used to indicate failure, while `Right` is used to indicate success. (Mnemonic: “right” is a synonym for “correct.”)
///
/// Otherwise, it is implied that `Left` and `Right` are effectively unordered alternatives of equal standing.
public enum Either<T, U>: EitherType, Printable {
	case Left(Box<T>)
	case Right(Box<U>)


	// MARK: Lifecycle

	/// Constructs a `Left`.
	///
	/// Suitable for partial application.
	public static func left(value: T) -> Either {
		return Left(Box(value))
	}

	/// Constructs a `Right`.
	///
	/// Suitable for partial application.
	public static func right(value: U) -> Either {
		return Right(Box(value))
	}


	// MARK: API

	/// Returns the result of applying `f` to the value of `Left`, or `g` to the value of `Right`.
	public func either<V>(f: T -> V, _ g: U -> V) -> V {
		switch self {
		case let .Left(x):
			return f(x.value)
		case let .Right(x):
			return g(x.value)
		}
	}

	/// Maps `Right` instances with `f`, and returns `Left` instances as-is.
	public func map<V>(f: U -> V) -> Either<T, V> {
		return either(Either<T, V>.left, f >>> Either<T, V>.right)
	}


	/// Returns the value of `Left` instances, or `nil` for `Right` instances.
	public var left: T? {
		return either(id, const(nil))
	}

	/// Returns the value of `Right` instances, or `nil` for `Left` instances.
	public var right: U? {
		return either(const(nil), id)
	}


	// MARK: Printable

	public var description: String {
		return either({ ".Left(\($0))"}, { ".Right(\($0))" })
	}
}


// MARK: - Free functions

/// If `left` is `Either.Right`, extracts its value and passes it to `right`, returning the result; otherwise transforms `left` into the return type.
///
/// This is the bind or flat map operator, and is useful for chaining computations taking some parameter and returning an `Either`.
public func >>- <T, U, V> (left: Either<T, U>, right: U -> Either<T, V>) -> Either<T, V> {
	return left.either(Either<T, V>.left, right)
}


// MARK: - Operators

infix operator >>- {
	// Left-associativity so that chaining works like you’d expect, and for consistency with Haskell, Runes, swiftz, etc.
	associativity left

	// Higher precedence than function application, but lower than function composition.
	precedence 150
}



// MARK: - Imports

import Box
import Prelude

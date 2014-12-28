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


	// MARK: Printable

	public var description: String {
		return either({ ".Left(\($0))"}, { ".Right(\($0))" })
	}
}


// MARK: Imports

import Box
import Prelude

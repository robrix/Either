//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A type representing an alternative of one of two types.
///
/// By convention, and where applicable, `Left` is used to indicate failure, while `Right` is used to indicate success. (Mnemonic: “right” is a synonym for “correct.”)
///
/// Otherwise, it is implied that `Left` and `Right` are effectively unordered alternatives of equal standing.
public enum Either<T, U>: EitherType, CustomDebugStringConvertible, CustomStringConvertible {
	case Left(T)
	case Right(U)


	// MARK: Lifecycle

	/// Constructs a `Left`.
	///
	/// Suitable for partial application.
	public static func left(value: T) -> Either {
		return Left(value)
	}

	/// Constructs a `Right`.
	///
	/// Suitable for partial application.
	public static func right(value: U) -> Either {
		return Right(value)
	}


	// MARK: API

	/// Returns the result of applying `f` to the value of `Left`, or `g` to the value of `Right`.
	public func either<Result>(@noescape ifLeft ifLeft: T throws -> Result, @noescape ifRight: U throws -> Result) rethrows -> Result {
		switch self {
		case let .Left(x):
			return try ifLeft(x)
		case let .Right(x):
			return try ifRight(x)
		}
	}

	/// Maps `Right` values with `transform`, and re-wraps `Left` values.
	public func map<V>(@noescape transform: U -> V) -> Either<T, V> {
		return flatMap { .right(transform($0)) }
	}

	/// Returns the result of applying `transform` to `Right` values, or re-wrapping `Left` values.
	public func flatMap<V>(@noescape transform: U -> Either<T, V>) -> Either<T, V> {
		return either(
			ifLeft: Either<T, V>.left,
			ifRight: transform)
	}

	/// Maps `Left` values with `transform`, and re-wraps `Right` values.
	public func mapLeft<V>(@noescape transform: T -> V) -> Either<V, U> {
		return flatMapLeft { .left(transform($0)) }
	}

	/// Returns the result of applying `transform` to `Left` values, or re-wrapping `Right` values.
	public func flatMapLeft<V>(@noescape transform: T -> Either<V, U>) -> Either<V, U> {
		return either(
			ifLeft: transform,
			ifRight: Either<V, U>.right)
	}


	/// Returns the value of `Left` instances, or `nil` for `Right` instances.
	public var left: T? {
		return either(
			ifLeft: unit,
			ifRight: const(nil))
	}

	/// Returns the value of `Right` instances, or `nil` for `Left` instances.
	public var right: U? {
		return either(
			ifLeft: const(nil),
			ifRight: unit)
	}


	/// Given equality functions for `T` and `U`, returns an equality function for `Either<T, U>`.
	public static func equals(left left: (T, T) -> Bool, right: (U, U) -> Bool) -> (Either<T, U>, Either<T, U>) -> Bool {
		return { a, b in
				(a.left &&& b.left).map(left)
			??	(a.right &&& b.right).map(right)
			??	false
		}
	}


	// MARK: CustomDebugStringConvertible

	public var debugDescription: String {
		return either(
			ifLeft: { ".Left(\(String(reflecting: $0)))" },
			ifRight: { ".Right(\(String(reflecting: $0)))" })
	}


	// MARK: CustomStringConvertible

	public var description: String {
		return either(
			ifLeft: { ".Left(\($0))"},
			ifRight: { ".Right(\($0))" })
	}
}


// MARK: - Free functions

/// If `left` is `Either.Right`, extracts its value and passes it to `transform`, returning the result; otherwise transforms `either` into the return type.
///
/// This is the bind or flat map operator, and is useful for chaining computations taking some parameter and returning an `Either`.
public func >>- <T, U, V> (either: Either<T, U>, @noescape transform: U -> Either<T, V>) -> Either<T, V> {
	return either.flatMap(transform)
}


// MARK: - Operators

infix operator >>- {
	// Left-associativity so that chaining works like you’d expect, and for consistency with Haskell, Runes, swiftz, etc.
	associativity left

	// Higher precedence than function application, but lower than function composition.
	precedence 100
}


// MARK: - Imports

import Prelude

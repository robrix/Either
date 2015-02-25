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
	static func left(value: Left) -> Self

	/// Constructs a `Right` instance.
	static func right(value: Right) -> Self

	/// Returns the result of applying `f` to `Left` values, or `g` to `Right` values.
	func either<Result>(@noescape #ifLeft: Left -> Result, @noescape ifRight: Right -> Result) -> Result
}


// MARK: API

/// Equality (tho not `Equatable`) over `EitherType` where `Left` & `Right` : `Equatable`.
public func == <E: EitherType where E.Left: Equatable, E.Right: Equatable> (lhs: E, rhs: E) -> Bool {
	return lhs.either(
		ifLeft: { $0 == rhs.either(ifLeft: unit, ifRight: const(nil)) },
		ifRight: { $0 == rhs.either(ifLeft: const(nil), ifRight: unit) })
}


/// Inequality over `EitherType` where `Left` & `Right` : `Equatable`.
public func != <E: EitherType where E.Left: Equatable, E.Right: Equatable> (lhs: E, rhs: E) -> Bool {
	return !(lhs == rhs)
}


// MARK: Imports

import Prelude

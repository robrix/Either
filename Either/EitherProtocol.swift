//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A type representing an alternative of one of two types.
///
/// By convention, and where applicable, `Left` is used to indicate failure, while `Right` is to indicate success. (Mnemonic: “right is right,” i.e. “right” is a synonym for “correct.”)
///
/// Otherwise it is implied that `Left` and `Right` are effectively unordered.
public protocol EitherProtocol {
	associatedtype Left
	associatedtype Right

	/// Constructs a `Left` instance.
	static func toLeft(_ value: Left) -> Self

	/// Constructs a `Right` instance.
	static func toRight(_ value: Right) -> Self

	/// Returns the result of applying `f` to `Left` values, or `g` to `Right` values.
	func either<Result>(ifLeft: (Left) throws -> Result, ifRight: (Right) throws -> Result) rethrows -> Result
}


extension EitherProtocol {
	/// Returns the value of `Left` instances, or `nil` for `Right` instances.
	public var left: Left? {
		return either(ifLeft: unit, ifRight: const(nil))
	}

	/// Returns the value of `Right` instances, or `nil` for `Left` instances.
	public var right: Right? {
		return either(ifLeft: const(nil), ifRight: unit)
	}
}


// MARK: API

extension EitherProtocol where Left: Equatable, Right: Equatable {
	/// Equality (tho not `Equatable`) over `EitherType` where `Left` & `Right` : `Equatable`.
	public static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.left == rhs.left && lhs.right == rhs.right
	}
	
	/// Inequality over `EitherType` where `Left` & `Right` : `Equatable`.
	public static func != (lhs: Self, rhs: Self) -> Bool {
		return !(lhs == rhs)
	}
}


// MARK: Imports

import Prelude

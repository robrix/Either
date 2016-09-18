//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A type representing an alternative of one of two types.
///
/// By convention, and where applicable, `Left` is used to indicate failure, while `Right` is to indicate success. (Mnemonic: “right is right,” i.e. “right” is a synonym for “correct.”)
///
/// Otherwise it is implied that `Left` and `Right` are effectively unordered.
public protocol EitherType {
	associatedtype LeftType
	associatedtype RightType

	/// Constructs a `Left` instance.
	static func with(left: LeftType) -> Self

	/// Constructs a `Right` instance.
	static func with(right: RightType) -> Self

	/// Returns the result of applying `f` to `Left` values, or `g` to `Right` values.
	func either<Result>(ifLeft: (LeftType) throws -> Result, ifRight: (RightType) throws -> Result) rethrows -> Result
}


extension EitherType {
	/// Returns the value of `Left` instances, or `nil` for `Right` instances.
	public var left: LeftType? {
		return either(ifLeft: unit, ifRight: const(nil))
	}

	/// Returns the value of `Right` instances, or `nil` for `Left` instances.
	public var right: RightType? {
		return either(ifLeft: const(nil), ifRight: unit)
	}
}


// MARK: API

extension EitherType where LeftType: Equatable, RightType: Equatable {
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

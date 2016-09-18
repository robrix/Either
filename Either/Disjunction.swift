//  Copyright (c) 2015 Rob Rix. All rights reserved.

// MARK: - Optional disjunction

/// Returns an `Either` representing the `left` operand if non-`nil`, or else the `right` if non-`nil`, or else `nil`.
///
/// Dual to `&&&`, defined in Prelude.
public func ||| <T, U> (left: T?, right: @autoclosure () -> U?) -> Either<T, U>? {
	return left.map(Either.left) ?? right().map(Either.right)
}


// MARK: - Operators

/// Same associativity and precedence as ||
infix operator ||| : LogicalConjunctionPrecedence

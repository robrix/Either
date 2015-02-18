//  Copyright (c) 2015 Rob Rix. All rights reserved.

// MARK: - Optional disjunction

func ||| <T, U> (left: T?, right: U?) -> Either<T, U>? {
	return left.map(Either.left) ?? right.map(Either.right)
}


// MARK: - Operators

infix operator ||| {
	/// Same associativity as ||.
	associativity left

	/// Same precedence as ||.
	precedence 110
}

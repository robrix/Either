//  Copyright (c) 2015 Rob Rix. All rights reserved.

// MARK: - Operators

infix operator ||| {
	/// Same associativity as ||.
	associativity left

	/// Same precedence as ||.
	precedence 110
}

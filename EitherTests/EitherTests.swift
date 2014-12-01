//  Copyright (c) 2014 Rob Rix. All rights reserved.

import Either
import XCTest

func id<T>(x: T) -> T { return x }

class EitherTests: XCTestCase {
	let left = Either<Int, String>.left(4)
	let right = Either<Int, String>.right("four")

	func testEitherExtractsFromLeft() {
		let value = left.either(id, countElements)
		XCTAssertEqual(value, 4)
	}

	func testEitherExtractsFromRight() {
		let value = right.either(toString, id)
		XCTAssertEqual(value, "four")
	}
}

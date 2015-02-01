//  Copyright (c) 2014 Rob Rix. All rights reserved.

import Either
import Prelude
import XCTest

final class EitherTests: XCTestCase {
	let left = Either<Int, String>.left(4)
	let right = Either<Int, String>.right("four")

	func isFull<T>(string: String) -> Either<T, Bool> {
		return .right(!string.isEmpty)
	}


	// MARK: - either

	func testEitherExtractsFromLeft() {
		let value = left.either(id, countElements)
		XCTAssertEqual(value, 4)
	}

	func testEitherExtractsFromRight() {
		let value = right.either(toString, id)
		XCTAssertEqual(value, "four")
	}


	// MARK: - map

	func testMapIgnoresLeftValues() {
		let result = left.map(const(5)).either(id, id)
		XCTAssertEqual(result, 4)
	}

	func testMapAppliesToRightValues() {
		let result = right.map(const(5)).either(id, id)
		XCTAssertEqual(result, 5)
	}
}

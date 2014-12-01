//  Copyright (c) 2014 Rob Rix. All rights reserved.

import Either
import XCTest

final class EitherTypeTests: XCTestCase {
	func testEqualityOverLeft() {
		XCTAssertTrue(Either<Int, Int>.left(1) == Either<Int, Int>.left(1))
		XCTAssertFalse(Either<Int, Int>.left(1) == Either<Int, Int>.left(2))
	}

	func testEqualityOverRight() {
		XCTAssertTrue(Either<Int, Int>.right(1) == Either<Int, Int>.right(1))
		XCTAssertFalse(Either<Int, Int>.right(1) == Either<Int, Int>.right(2))
	}

	func testInequalityOverLeft() {
		XCTAssertTrue(Either<Int, Int>.left(1) != Either<Int, Int>.left(2))
		XCTAssertFalse(Either<Int, Int>.left(1) != Either<Int, Int>.left(1))
	}

	func testInequalityOverRight() {
		XCTAssertFalse(Either<Int, Int>.right(1) != Either<Int, Int>.right(1))
		XCTAssertTrue(Either<Int, Int>.right(1) != Either<Int, Int>.right(2))
	}
}

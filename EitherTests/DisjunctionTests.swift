//  Copyright (c) 2015 Rob Rix. All rights reserved.

final class DisjunctionTests: XCTestCase {
	func testDropsNilOperands() {
		XCTAssert(((nil as Int?) ||| (nil as Int?)).map(const(true)) == nil)
	}

	func testAlternatesNonNilOperands() {
		XCTAssert(((nil as Int?) ||| 1)?.either(unit, unit) == 1)
		XCTAssert((1 ||| (nil as Int?))?.either(unit, unit) == 1)
		XCTAssert((1 ||| 2)?.either(unit, unit) == 1)
		XCTAssert(((nil as Int?) ||| (nil as Int?)) == nil)
	}

	func testShortCircuits() {
		var effects = 0
		let right = { ++effects }
		XCTAssert((0 as Int? ||| right())?.either(unit, unit) == 0)
		XCTAssertEqual(effects, 0)
	}
}

// MARK: - Imports

import Either
import Prelude
import XCTest

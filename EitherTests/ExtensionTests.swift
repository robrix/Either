//  Copyright (c) 2016 Rob Rix. All rights reserved.

import Either
import XCTest

final class ExtensionTests: XCTestCase {
	
	// Sequence
	
	func testRightsSelectOnlyRight() {
		let list: [Either<Int, Int>] = [.right(0), .left(1), .left(2), .right(3)]
		XCTAssertEqual(list.rights(), [0, 3])
	}
	
	func testLeftsSelectOnlyLeft() {
		let list: [Either<Int, Int>] = [.right(0), .left(1), .left(2), .right(3)]
		XCTAssertEqual(list.lefts(), [1, 2])
	}
}
